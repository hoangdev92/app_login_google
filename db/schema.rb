# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_22_154245) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "parent_id", default: 0
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "category_changes_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "modifier_id"
    t.integer "kind", limit: 1
    t.string "fields"
    t.string "content"
    t.datetime "created_at"
    t.index ["category_id"], name: "index_category_changes_histories_on_category_id"
    t.index ["modifier_id"], name: "index_category_changes_histories_on_modifier_id"
  end

  create_table "category_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id"
    t.integer "language", limit: 1, default: 0
    t.string "content"
    t.index ["category_id"], name: "index_category_names_on_category_id"
  end

  create_table "fund_changes_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "fund_id"
    t.bigint "modifier_id"
    t.integer "kind", limit: 1
    t.string "fields"
    t.string "content"
    t.datetime "created_at"
    t.index ["fund_id"], name: "index_fund_changes_histories_on_fund_id"
    t.index ["modifier_id"], name: "index_fund_changes_histories_on_modifier_id"
  end

  create_table "funds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.bigint "owner_id"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_funds_on_code"
    t.index ["owner_id"], name: "index_funds_on_owner_id"
  end

  create_table "legal_entities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.string "sync_code"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_legal_entities_on_code"
    t.index ["sync_code"], name: "index_legal_entities_on_sync_code"
  end

  create_table "legal_entity_changes_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "legal_entity_id"
    t.bigint "modifier_id"
    t.integer "kind", limit: 1
    t.string "fields"
    t.string "content"
    t.datetime "created_at"
    t.index ["legal_entity_id"], name: "index_legal_entity_changes_histories_on_legal_entity_id"
    t.index ["modifier_id"], name: "index_legal_entity_changes_histories_on_modifier_id"
  end

  create_table "legal_entity_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "legal_entity_id"
    t.integer "language", limit: 1, default: 0
    t.string "content"
    t.index ["legal_entity_id"], name: "index_legal_entity_names_on_legal_entity_id"
  end

  create_table "product_changes_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "modifier_id"
    t.integer "kind", limit: 1
    t.string "fields"
    t.string "content"
    t.datetime "created_at"
    t.index ["modifier_id"], name: "index_product_changes_histories_on_modifier_id"
    t.index ["product_id"], name: "index_product_changes_histories_on_product_id"
  end

  create_table "product_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "language", limit: 1, default: 0
    t.string "content"
    t.index ["product_id"], name: "index_product_names_on_product_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_products_on_code"
  end

  create_table "user_changes_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "modifier_id"
    t.integer "kind", limit: 1
    t.string "fields"
    t.string "content"
    t.datetime "created_at"
    t.index ["modifier_id"], name: "index_user_changes_histories_on_modifier_id"
    t.index ["user_id"], name: "index_user_changes_histories_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "full_name"
    t.string "first_name"
    t.string "last_name"
    t.string "avatar", limit: 500
    t.integer "status", limit: 1, default: 1
    t.integer "role", limit: 1, default: 0
    t.string "google_id"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "token_expires_at"
    t.string "templates_folder_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["google_id"], name: "index_users_on_google_id", unique: true
  end

end
