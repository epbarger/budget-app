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

ActiveRecord::Schema.define(version: 20160720165316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balance_events", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "budget_cycle_id"
    t.integer  "amount"
    t.string   "note"
    t.index ["budget_cycle_id"], name: "index_balance_events_on_budget_cycle_id", using: :btree
  end

  create_table "budget_cycles", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "budget_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "period_balance"
    t.index ["budget_id"], name: "index_budget_cycles_on_budget_id", using: :btree
  end

  create_table "budgets", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "account_id"
    t.integer  "period"
    t.boolean  "monthly",          default: true
    t.integer  "replenish_period", default: 1
    t.boolean  "reoccuring",       default: true
    t.integer  "amount"
    t.string   "name"
    t.datetime "hidden_at"
    t.index ["account_id"], name: "index_budgets_on_account_id", using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

end
