# frozen_string_literal: true

class Product::ChangesHistory < ApplicationRecord
  include Historiable

  belongs_to :product, class_name: 'Product', inverse_of: :changes_histories
  belongs_to :modifier, class_name: 'User', inverse_of: :modified_products_histories

  delegate :id, :email, :full_name, to: :modifier, prefix: true, allow_nil: true
end
