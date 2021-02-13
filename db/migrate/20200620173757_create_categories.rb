# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.references :parent, references: :categories, default: 0
      t.integer    :availability, limit: 1, default: 1
      t.datetime   :deleted_at
      t.timestamps
    end

    create_table :category_names do |t|
      t.belongs_to :category
      t.integer    :language, limit: 1, default: 0
      t.string     :content
    end

    create_table :category_changes_histories do |t|
      t.belongs_to :category
      t.belongs_to :modifier, references: :users
      t.integer    :kind, limit: 1
      t.string     :fields, limit: 255
      t.string     :content
      t.datetime   :created_at
    end
  end
end
