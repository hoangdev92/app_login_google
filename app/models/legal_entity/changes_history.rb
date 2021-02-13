# frozen_string_literal: true

class LegalEntity::ChangesHistory < ApplicationRecord
  include Historiable

  belongs_to :legal_entity, class_name: 'LegalEntity', inverse_of: :changes_histories
  belongs_to :modifier, class_name: 'User', inverse_of: :modified_legal_entities_histories

  delegate :id, :email, :full_name, to: :modifier, prefix: true, allow_nil: true
end
