class CreateFunds < ActiveRecord::Migration[6.0]
  def change
    create_table :funds do |t|
      t.string     :code, index: true
      t.belongs_to :owner, references: :users, index: true
      t.integer    :availability, limit: 1, default: 1
      t.datetime   :deleted_at
      t.timestamps
    end

    create_table :fund_changes_histories do |t|
      t.belongs_to :fund
      t.belongs_to :modifier, references: :users
      t.integer    :kind, limit: 1
      t.string     :fields, limit: 255
      t.string     :content
      t.datetime   :created_at
    end
  end
end
