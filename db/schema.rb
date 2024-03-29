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

ActiveRecord::Schema[7.0].define(version: 2023_04_13_015518) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "balance", default: "0.0", null: false
    t.boolean "active", default: false, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "checking_accounts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "account_number"
    t.decimal "monthly_fee", default: "0.0", null: false
    t.string "agency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_checking_accounts_on_account_id"
    t.index ["account_number", "agency"], name: "index_checking_accounts_on_account_number_and_agency", unique: true
  end

  create_table "debts", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.decimal "value", default: "0.0", null: false
    t.datetime "date"
    t.boolean "is_installments", null: false
    t.integer "installments"
    t.bigint "tags_id"
    t.bigint "accounts_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounts_id"], name: "index_debts_on_accounts_id"
    t.index ["tags_id"], name: "index_debts_on_tags_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.decimal "value", default: "0.0", null: false
    t.datetime "date"
    t.boolean "continuous", null: false
    t.bigint "tags_id"
    t.bigint "accounts_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounts_id"], name: "index_incomes_on_accounts_id"
    t.index ["tags_id"], name: "index_incomes_on_tags_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "value", null: false
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "typeable_type"
    t.bigint "typeable_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["typeable_type", "typeable_id"], name: "index_transactions_on_typeable"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "checking_accounts", "accounts"
  add_foreign_key "debts", "accounts", column: "accounts_id"
  add_foreign_key "debts", "tags", column: "tags_id"
  add_foreign_key "incomes", "accounts", column: "accounts_id"
  add_foreign_key "incomes", "tags", column: "tags_id"
  add_foreign_key "transactions", "accounts"
end
