# frozen_string_literal: true

class Product::Name < ApplicationRecord
  include LogicalDelete
  include Languagable

  belongs_to :product

  validates :content, presence: true, length: { maximum: 255 }
end
