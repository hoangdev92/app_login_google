# frozen_string_literal: true

class LegalEntity < ApplicationRecord
  include LogicalDelete

  has_many :names, class_name: 'LegalEntity::Name', inverse_of: :legal_entity
  has_many :changes_histories, class_name: 'LegalEntity::ChangesHistory', inverse_of: :legal_entity

  validates :code, :sync_code, presence: true,
                               uniqueness: { case_sensitive: false },
                               length: { maximum: 255 }

  accepts_nested_attributes_for :names, :changes_histories
end
