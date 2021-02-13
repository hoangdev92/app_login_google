# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      # Core information
      t.string   :email, default: '', null: false
      t.string   :full_name
      t.string   :first_name
      t.string   :last_name
      t.string   :avatar,     limit: 500
      t.integer  :status,     limit: 1, default: 1
      t.integer  :role,       limit: 1, default: 0

      # Google Authentication
      t.string   :google_id
      t.string   :access_token
      t.string   :refresh_token
      t.datetime :token_expires_at

      # Google Drive Information
      t.string   :templates_folder_id

      t.timestamps
    end

    create_table :user_changes_histories do |t|
      t.belongs_to :user
      t.belongs_to :modifier, references: :users
      t.integer    :kind, limit: 1
      t.string     :fields, limit: 255
      t.string     :content
      t.datetime   :created_at
    end

    add_index :users, :email, unique: true
    add_index :users, :google_id, unique: true
  end
end
