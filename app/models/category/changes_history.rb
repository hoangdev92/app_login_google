# frozen_string_literal: true

class Category::ChangesHistory < ApplicationRecord
  include Historiable

  belongs_to :category, class_name: 'Category', inverse_of: :changes_histories
  belongs_to :modifier, class_name: 'User', inverse_of: :modified_categories_histories

  delegate :id, :email, :full_name, to: :modifier, prefix: true, allow_nil: true
end
