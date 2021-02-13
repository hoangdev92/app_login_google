# frozen_string_literal: true

module Auth
  class SignInService
    attr_reader :user

    USER_INFO_URL = 'https://www.googleapis.com/oauth2/v3/userinfo?alt=json&access_token=%<token>s'

    def initialize(params)
      @client = Google::CredentialsService.instance.base_authorization
      @client.code = params[:code]
    end

    def verify_access!
      @client.fetch_access_token!

      user_info = HTTParty.get(format(USER_INFO_URL, token: @client.access_token))
      raise Errors::NotAvailableEmail unless available_email?(user_info['email'])

      create_or_update_user_depends_on user_info
    rescue StandardError
      raise Errors::Authentication::GoogleAuthenticationFailed
    end

    def verified_tokens
      {
        access_token: JsonWebToken.encode({
                                            user_id: @user.id,
                                            refresh_token: random_refresh_token
                                          }, :access_token_duration),
        refresh_token: JsonWebToken.encode({ content: random_refresh_token }, :default_duration)
      }
    end

    private

    # For data validations and current server actions
    def available_email?(email)
      Rails.configuration.available_email_domains.include? email.split('@').last
    end

    def create_or_update_user_depends_on(info)
      @user = User.find_or_initialize_by(email: info['email'])
      @user.assign_attributes full_name: info['name'],
                              first_name: info['given_name'],
                              last_name: info['family_name'],
                              avatar: info['picture'],
                              google_id: info['sub'],
                              access_token: @client.access_token,
                              refresh_token: @client.refresh_token.presence || @user.refresh_token,
                              token_expires_at: @client.expires_at
      @user.save!
    end
  end
end
