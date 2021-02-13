# frozen_string_literal: true

class Product < ApplicationRecord
  include LogicalDelete

  has_many :names, class_name: 'Product::Name', inverse_of: :product
  has_many :changes_histories, class_name: 'Product::ChangesHistory', inverse_of: :product

  validates :code, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 255 }

  accepts_nested_attributes_for :names, :changes_histories
end
