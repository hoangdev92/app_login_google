# frozen_string_literal: true

module Record
  class DestroyWithHistoryService
    def destroy!(record, parameters, modifier)
      raise Errors::Record::AlreadyDestroyed if record.already_destroyed?

      record.assign_attributes history_parameters(parameters, modifier)
      record.destroy!
    end

    private

    def history_parameters(params, modifier)
      {
        changes_histories_attributes: [
          {
            kind: :destroy,
            modifier_id: modifier.id,
            content: params.dig(:changes_histories_attributes,
                                :content).presence || I18n.t('changes_histories.destroy')
          }
        ]
      }
    end
  end
end
