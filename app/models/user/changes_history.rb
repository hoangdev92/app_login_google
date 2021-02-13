# frozen_string_literal: true

class User::ChangesHistory < ApplicationRecord
  include Historiable

  belongs_to :user, class_name: 'User', foreign_key: :user_id, inverse_of: :changes_histories
  belongs_to :modifier, class_name: 'User', foreign_key: :modifier_id, inverse_of: :modified_histories

  delegate :id, :email, :full_name, to: :modifier, prefix: true, allow_nil: true
end
