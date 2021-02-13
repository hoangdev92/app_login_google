# frozen_string_literal: true

module Record
  class CreateWithHistoryService
    attr_reader :record

    def create!(klass, parameters, modifier)
      parameters.merge! history_parameters(modifier)
      @record = klass.create! parameters
    end

    private

    def history_parameters(modifier)
      {
        changes_histories_attributes: [
          {
            kind: :create,
            modifier_id: modifier.id,
            content: I18n.t('changes_histories.create')
          }
        ]
      }
    end
  end
end
