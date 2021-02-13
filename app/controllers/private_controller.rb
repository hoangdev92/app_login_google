# frozen_string_literal: true

class PrivateController < ApplicationController
  before_action :authenticate_user!

  helper_method :current_user

  protected

  def authenticate_user!
    raise Errors::Authentication::Unauthorized if current_user.blank?
    raise Errors::Authentication::DeactivedAccount if current_user.inactive?
  end

  def current_user
    @current_user ||= begin
      decoded = JsonWebToken.decode access_token
      User.find decoded[:user_id]
    end
  end
end
