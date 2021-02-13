# frozen_string_literal: true

module Languagable
  extend ActiveSupport::Concern

  included do
    enum language: Rails.configuration.available_languages, _suffix: true

    validates_inclusion_of :language, in: Rails.configuration.available_languages
  end
end
