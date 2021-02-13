# frozen_string_literal: true

module Record
  class RestoreWithHistoryService
    def restore!(record, parameters, modifier)
      raise Errors::Record::AlreadyRestored if record.already_restored?

      record.assign_attributes history_parameters(parameters, modifier)
      record.restore!
    end

    private

    def history_parameters(params, modifier)
      {
        changes_histories_attributes: [
          {
            kind: :restore,
            modifier_id: modifier.id,
            content: params.dig(:changes_histories_attributes,
                                :content).presence || I18n.t('changes_histories.restore')
          }
        ]
      }
    end
  end
end
