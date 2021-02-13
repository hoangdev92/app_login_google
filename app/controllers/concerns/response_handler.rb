# frozen_string_literal: true

module ResponseHandler
  def render_success(message: :requested_successfully, code: :success, data: nil)
    render json: {
      status: true,
      message: I18n.t("announcements.#{message}"),
      code: Rails.configuration.responses.code[code],
      data: data
    }, status: :ok
  end
end
