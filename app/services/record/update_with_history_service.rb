# frozen_string_literal: true

module Record
  class UpdateWithHistoryService
    def update!(record, parameters, modifier)
      record.tap do |r|
        r.assign_attributes parameters
        changes_keys = changes_attributes_of r
        r.assign_attributes history_parameters(changes_keys, modifier)
        r.save!
      end
    end

    private

    def history_parameters(changes_attributes, modifier)
      {
        changes_histories_attributes: [
          {
            kind: :update,
            modifier_id: modifier.id,
            content: I18n.t('changes_histories.update'),
            fields: changes_attributes
          }
        ]
      }
    end

    def changes_attributes_of(record)
      record.changes.keys.tap do |attributes|
        attributes << 'names' if record.respond_to?(:names) && record.names.any?(&:changed?)
      end
    end
  end
end
