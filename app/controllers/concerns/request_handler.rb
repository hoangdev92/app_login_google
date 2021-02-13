# frozen_string_literal: true

module RequestHandler
  extend ActiveSupport::Concern

  included do
    def access_token
      authorization = request.headers['Authorization']
      raise Errors::Authentication::Unauthorized if authorization.blank?

      authorization.split(' ').last
    end
  end
end
