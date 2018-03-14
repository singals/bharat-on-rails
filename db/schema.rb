# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20170802065900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.string "package_quantity"
    t.integer "availabe_units"
    t.float "mrp"
    t.float "cost"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debtors", force: :cascade do |t|
    t.string "name"
    t.string "village"
    t.string "phone"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profit_and_loss_accounts", force: :cascade do |t|
    t.string "description"
    t.float "amount"
    t.float "current_balance"
    t.string "financial_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["financial_year"], name: "index_profit_and_loss_accounts_on_financial_year"
  end

  create_table "purchase_items", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "purchase_id"
    t.integer "quantity"
    t.float "price"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_purchase_items_on_article_id"
    t.index ["purchase_id"], name: "index_purchase_items_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "seller_name"
    t.string "city"
    t.string "phone"
    t.integer "invoice_number"
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sale_items", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "sale_id"
    t.integer "quantity"
    t.float "price"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_sale_items_on_article_id"
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "nature"
    t.bigint "debtor_id"
    t.string "village"
    t.string "phone"
    t.float "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_settled"
    t.index ["debtor_id"], name: "index_sales_on_debtor_id"
  end

  add_foreign_key "purchase_items", "articles"
  add_foreign_key "purchase_items", "purchases"
  add_foreign_key "sale_items", "articles"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sales", "debtors"
end
