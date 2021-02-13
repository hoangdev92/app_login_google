# frozen_string_literal: true

class User < ApplicationRecord
  enum role: { standard: 0, manager: 1, administrator: 9 }
  enum status: { inactive: 0, active: 1 }

  has_many :funds, class_name: 'Fund', inverse_of: :user

  # BEGIN: Changes histories
  has_many :changes_histories, class_name: 'User::ChangesHistory', foreign_key: :user_id, inverse_of: :user
  has_many :modified_histories, class_name: 'User::ChangesHistory', foreign_key: :modifier_id, inverse_of: :modifier
  has_many :modified_legal_entities_histories, class_name: 'LegalEntity::ChangesHistory',
                                               foreign_key: :modifier_id, inverse_of: :modifier
  has_many :modified_categories_histories, class_name: 'Category::ChangesHistory',
                                           foreign_key: :modifier_id, inverse_of: :modifier
  has_many :modified_products_histories, class_name: 'Product::ChangesHistory',
                                         foreign_key: :modifier_id, inverse_of: :modifier
  has_many :modified_funds_histories, class_name: 'Fund::ChangesHistory',
                                      foreign_key: :modifier_id, inverse_of: :modifier
  # END: Changes histories

  validates_uniqueness_of :email, :google_id, case_sensitive: false
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  accepts_nested_attributes_for :funds

  # True/False conditions
  def ready_for_drive?
    templates_folder_id.present?
  end

  def need_refresh_google_token?
    token_expires_at < (Time.zone.now - 2.minutes)
  end

  # Getters
  def avatar_in_size(size)
    "avatar=s#{size}-c"
  end

  def google_token_informations
    @google_token_informations ||= { access_token: access_token,
                                     refresh_token: refresh_token,
                                     expires_at: token_expires_at }
  end
end
