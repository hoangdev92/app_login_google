# frozen_string_literal: true

class LegalEntity::Name < ApplicationRecord
  include LogicalDelete
  include Languagable

  belongs_to :legal_entity

  validates :content, presence: true, length: { maximum: 255 }
end
