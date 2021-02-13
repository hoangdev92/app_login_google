# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string   :code, index: true
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :product_names do |t|
      t.belongs_to :product
      t.integer    :language, limit: 1, default: 0
      t.string     :content
    end

    create_table :product_changes_histories do |t|
      t.belongs_to :product
      t.belongs_to :modifier, references: :users
      t.integer    :kind, limit: 1
      t.string     :fields, limit: 255
      t.string     :content
      t.datetime   :created_at
    end
  end
end
