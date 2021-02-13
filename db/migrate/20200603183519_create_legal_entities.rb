# frozen_string_literal: true

class CreateLegalEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :legal_entities do |t|
      t.string   :code, index: true
      t.string   :sync_code, index: true
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :legal_entity_names do |t|
      t.belongs_to :legal_entity
      t.integer    :language, limit: 1, default: 0
      t.string     :content
    end

    create_table :legal_entity_changes_histories do |t|
      t.belongs_to :legal_entity
      t.belongs_to :modifier, references: :users
      t.integer    :kind, limit: 1
      t.string     :fields, limit: 255
      t.string     :content
      t.datetime   :created_at
    end
  end
end
