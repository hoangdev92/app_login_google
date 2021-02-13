# frozen_string_literal: true

class Fund < ApplicationRecord
  include LogicalDelete

  has_many :changes_histories, class_name: 'Fund::ChangesHistory', inverse_of: :fund
  belongs_to :owner, class_name: 'User', inverse_of: :funds

  validates :code, presence: true, length: { maximum: 255 },
                   uniqueness: { case_sensitive: false }

  delegate :full_name, :email, to: :owner, prefix: true, allow_nil: true

  accepts_nested_attributes_for :changes_histories
end
