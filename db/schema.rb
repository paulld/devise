# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150113123651) do

  create_table "airlines", force: true do |t|
    t.string   "name"
    t.string   "iata"
    t.string   "icao"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airplanes", force: true do |t|
    t.integer  "airline_id"
    t.string   "registration_code"
    t.string   "mode_s"
    t.string   "plane_type_code"
    t.string   "plane_type"
    t.string   "s_n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "annualincomes", force: true do |t|
    t.integer  "company_id"
    t.string   "currency"
    t.date     "period"
    t.decimal  "revenue"
    t.decimal  "other_revenue"
    t.decimal  "total_revenue"
    t.decimal  "total_cost_of_revenue"
    t.decimal  "gross_profit"
    t.decimal  "general_expense"
    t.decimal  "randd"
    t.decimal  "depreciation"
    t.decimal  "interest_expense"
    t.decimal  "unusual_expense"
    t.decimal  "other_operating_expense"
    t.decimal  "total_operating_expense"
    t.decimal  "operating_income"
    t.decimal  "interest_income"
    t.decimal  "gain_on_sale_of_asset"
    t.decimal  "other_income"
    t.decimal  "income_before_tax"
    t.decimal  "income_after_tax"
    t.decimal  "minority_interest"
    t.decimal  "equity_in_affiliates"
    t.decimal  "net_income_before_extra_item"
    t.decimal  "accounting_change"
    t.decimal  "discontinued_operations"
    t.decimal  "extra_item"
    t.decimal  "net_income"
    t.decimal  "preferred_dividends"
    t.decimal  "income_available_to_common_excl_extra"
    t.decimal  "income_available_to_common_incl_extra"
    t.decimal  "basic_weighted_average_shares"
    t.decimal  "basic_eps_excl_extra_items"
    t.decimal  "basic_eps_incl_extra_items"
    t.decimal  "dilution_adjustment"
    t.decimal  "diluted_weighted_average_shares"
    t.decimal  "diluted_eps_exclextra_items"
    t.decimal  "diluted_eps_inclextra_items"
    t.decimal  "dividends_per_share"
    t.decimal  "gross_dividends"
    t.decimal  "net_income_after_stock_expense"
    t.decimal  "basic_eps_after_stock_expense"
    t.decimal  "diluted_eps_after_stock_expense"
    t.decimal  "supplement_depreciation"
    t.decimal  "total_special_items"
    t.decimal  "normalized_income_before_taxes"
    t.decimal  "effect_of_special_items_on_income_taxes"
    t.decimal  "income_taxes_impact_of_special_items"
    t.decimal  "normalized_income_after_taxes"
    t.decimal  "normalized_income_avail_to_common"
    t.decimal  "basic_normalized_eps"
    t.decimal  "diluted_normalized_eps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "stock_exchange"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
