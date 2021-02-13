# frozen_string_literal: true

class Category::Name < ApplicationRecord
  include LogicalDelete
  include Languagable

  belongs_to :category

  validates :content, presence: true, length: { maximum: 255 },
                      uniqueness: { case_sensitive: false }
end
