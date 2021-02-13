# frozen_string_literal: true

module Errors
  class RecordInvalidHandler
    def initialize(record)
      @resource = record.class.name.underscore
      @errors = record.errors
    end

    def data_to_response
      {
        status: false,
        error: {
          code: Rails.configuration.responses.dig(:code, :record_invalid),
          name: 'record_invalid',
          message: I18n.t('responses.record_invalid'),
          details: data_to_hash
        }
      }
    end

    private

    def build_error_info(resource, attribute, messages)
      {
        resource: resource,
        attribute: attribute,
        messages: messages
      }
    end

    def build_error_info_of(attribute_name)
      model, attribute = attribute_name.split('.')

      if attribute.present?
        build_error_info model.singularize, attribute, @errors.full_messages_for(attribute_name)
      else
        build_error_info @resource, attribute_name, @errors.full_messages_for(attribute_name)
      end
    end

    def data_to_hash
      @errors.keys.map(&:to_s).map { |attribute| build_error_info_of(attribute) }
    end
  end
end
