class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :created_at_desc, -> { order created_at: :desc }
end
