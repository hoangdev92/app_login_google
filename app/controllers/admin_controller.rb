# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!

  helper_method :current_user

  protected

  def authenticate_user!
    raise Errors::Authentication::Unauthorized if current_user.blank?
    raise Errors::Authentication::DeactivedAccount if current_user.inactive?
    raise Errors::Authentication::PermissionDenied unless current_user.administrator?
  end

  def current_user
    @current_user ||= begin
      decoded = JsonWebToken.decode access_token
      User.find_by id: decoded[:user_id]
    end
  end
end
