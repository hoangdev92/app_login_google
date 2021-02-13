# frozen_string_literal: true

class Fund::ChangesHistory < ApplicationRecord
  include Historiable

  belongs_to :fund, class_name: 'Fund', inverse_of: :changes_histories
  belongs_to :modifier, class_name: 'User', inverse_of: :modified_funds_histories

  delegate :id, :email, :full_name, to: :modifier, prefix: true, allow_nil: true
end
