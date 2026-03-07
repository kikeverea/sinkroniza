# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_06_26_100750) do
  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.string "name"
    t.string "legal_name"
    t.string "tax_id"
    t.text "address"
    t.string "cp"
    t.string "logo"
    t.string "manager_name"
    t.string "manager_lastname"
    t.string "manager_email"
    t.string "manager_nif"
    t.string "manager_phone"
    t.boolean "active", default: true
    t.integer "creator_user_id"
    t.string "creator_user_name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_companies_on_subscription_id"
  end

  create_table "credentials", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "web_company_type"
    t.string "name"
    t.text "description"
    t.text "admin_description"
    t.text "encrypted_blob"
    t.string "mediator_code"
    t.string "priority"
    t.string "owner"
    t.boolean "visible_extension"
    t.boolean "active", default: true
    t.string "credential_type"
    t.bigint "company_id", null: false
    t.bigint "web_id", null: false
    t.bigint "group_id"
    t.bigint "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_credentials_on_company_id"
    t.index ["folder_id"], name: "index_credentials_on_folder_id"
    t.index ["group_id"], name: "index_credentials_on_group_id"
    t.index ["web_id"], name: "index_credentials_on_web_id"
  end

  create_table "folders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "company_id"
    t.bigint "parent_folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_folders_on_company_id"
    t.index ["parent_folder_id"], name: "index_folders_on_parent_folder_id"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name"
    t.text "description"
    t.integer "created_by_user_id"
    t.string "group_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_groups_on_company_id"
  end

  create_table "logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "user_name"
    t.integer "company_id"
    t.string "company_name"
    t.text "action"
    t.string "log_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "quantity_users"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "lastname"
    t.string "image"
    t.string "jti"
    t.string "nif"
    t.string "role"
    t.string "status"
    t.datetime "last_connection"
    t.datetime "date_expiration_password"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "web_companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "web_company_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "web_company_id", null: false
    t.string "web_company_type"
    t.string "name"
    t.string "alias"
    t.string "logo"
    t.string "access_url"
    t.boolean "active", default: true
    t.integer "creator_user_id"
    t.string "creator_user_name"
    t.string "status"
    t.string "send_button"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["web_company_id"], name: "index_webs_on_web_company_id"
  end

  add_foreign_key "companies", "subscriptions"
  add_foreign_key "credentials", "companies"
  add_foreign_key "credentials", "folders"
  add_foreign_key "credentials", "groups"
  add_foreign_key "credentials", "webs"
  add_foreign_key "folders", "companies"
  add_foreign_key "folders", "folders", column: "parent_folder_id"
  add_foreign_key "groups", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "webs", "web_companies"
end
