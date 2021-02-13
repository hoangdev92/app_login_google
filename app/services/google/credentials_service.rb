# frozen_string_literal: true

require 'signet/oauth_2/client'

module Google
  class CredentialsService
    def initialize
      @client = Signet::OAuth2::Client.new(
        authorization_uri: ENV['GOOGLE_AUTH_URI'],
        token_credential_uri: ENV['GOOGLE_AUTH_TOKEN_URI'],
        client_id: ENV['GOOGLE_AUTH_CLIENT_ID'],
        client_secret: ENV['GOOGLE_AUTH_CLIENT_SECRET'],
        scope: ENV['GOOGLE_AUTH_SCOPES'],
        redirect_uri: ENV['GOOGLE_AUTH_REDIRECT_URI'],
        additional_parameters: { access_type: 'offline', include_granted_scopes: 'true' }
      )
    end

    class << self
      attr_reader :instance
    end

    def base_authorization
      @client
    end

    def authorization_of(user)
      authorization = base_authorization
      authorization.update! user.google_token_informations

      if user.need_refresh_google_token?
        authorization.refresh!
        update_token_informations_of authorization, user
      end

      authorization
    rescue StandardError => e
      Rails.logger.error "GOOGLE CREDENTIALS ERROR: #{e.message}"
      raise Errors::Authentication::RefreshGoogleCredentialsFail
    end

    @instance = new

    private_class_method :new

    private

    def update_token_informations_of(authorization, user)
      user.update access_token: authorization.access_token,
                  refresh_token: authorization.refresh_token.presence || user.refresh_token,
                  token_expires_at: authorization.expires_at
    end
  end
end
