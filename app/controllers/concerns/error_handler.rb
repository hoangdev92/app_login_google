# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from Exception do |e|
    #   if e.class == ActiveRecord::RecordInvalid
    #     render json: Errors::RecordInvalidHandler.new(e.record).data_to_response,
    #            status: :unprocessable_entity
    #   else
    #     error = informations_of(e)
    #     render json: {
    #       status: false,
    #       error: { code: error[:code],
    #                name: error[:name],
    #                message: I18n.t("responses.#{error[:name]}") }
    #     }, status: error[:status]
    #   end
    # end
  end

  private

  def informations_of(error)
    error_name = error.class.name.demodulize.underscore.to_sym
    error_responses = Rails.configuration.responses.errors
    error_responses[error_name] || error_responses[:bad_request]
  end
end
