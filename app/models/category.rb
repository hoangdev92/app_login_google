# frozen_string_literal: true

class Category < ApplicationRecord
  include LogicalDelete

  has_many :names, class_name: 'Category::Name', inverse_of: :category
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  has_many :changes_histories, class_name: 'Category::ChangesHistory', inverse_of: :category
  belongs_to :parent, class_name: 'Category', optional: true

  scope :main_categories, -> { where parent_id: 0 }

  with_options if: -> { parent_id != 0 } do
    validates_presence_of :parent
  end

  accepts_nested_attributes_for :names, :changes_histories
end
