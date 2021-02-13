# frozen_string_literal: true

module Historiable
  extend ActiveSupport::Concern

  included do
    enum kind: { create: 0, update: 1, destroy: 2, restore: 3 }, _prefix: true

    serialize :fields, Array
  end
end
