# frozen_string_literal: true

# Include this module to get the logical deletion ability
# Make sure there fields:
# ````
# t.integer  :availability, limit: 1
# t.datetime :deleted_at
# ````
# are declared in the corresponding migration file

module LogicalDelete
  extend ActiveSupport::Concern

  included do
    enum availability: { unavailable: 0, available: 1 }

    scope :not_deleted, -> { where deleted_at: nil }
    scope :availability_desc, -> { order availability: :desc }

    def already_destroyed?
      unavailable? && deleted_at.present?
    end

    def already_restored?
      available? && deleted_at.blank?
    end

    def destroy
      assign_attributes availability: :unavailable, deleted_at: Time.zone.now
      save validate: false
      run_callbacks :destroy
      freeze
    end

    def restore!
      assign_attributes availability: :available, deleted_at: nil
      save validate: false
    end
  end
end
