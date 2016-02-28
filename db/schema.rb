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

ActiveRecord::Schema.define(version: 20160228055537) do

  create_table "market_watch_data", force: true do |t|
    t.string   "average_recommendation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_id"
  end

  add_index "market_watch_data", ["stock_id"], name: "index_market_watch_data_on_stock_id"

  create_table "stocks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "exchange"
    t.string   "symbol"
  end

  create_table "street_insider_data", force: true do |t|
    t.string   "average_recommendation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_id"
  end

  add_index "street_insider_data", ["stock_id"], name: "index_street_insider_data_on_stock_id"

  create_table "yahoo_data", force: true do |t|
    t.decimal "current_eps"
    t.decimal "dividends_per_share"
    t.decimal "day_high_price"
    t.decimal "day_low_price"
    t.decimal "book_value"
    t.decimal "price_to_book_ratio"
    t.decimal "price_to_earnings_ratio"
    t.decimal "year_low_price"
    t.decimal "year_high_price"
    t.integer "stock_id"
    t.decimal "ebitda"
    t.decimal "market_cap"
    t.decimal "one_year_target_price"
    t.decimal "fifty_day_moving_average"
    t.decimal "percent_change_from_fifty_day_moving_average"
    t.decimal "two_hundred_day_moving_average"
    t.decimal "percent_change_from_two_hundred_day_moving_average"
    t.decimal "last_trade_price"
    t.decimal "dividend_yield"
  end

  add_index "yahoo_data", ["stock_id"], name: "index_yahoo_data_on_stock_id"

end
