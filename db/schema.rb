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

ActiveRecord::Schema.define(version: 20160220043554) do

  create_table "stocks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "exchange"
    t.string   "symbol"
    t.decimal  "current_eps"
    t.decimal  "dividends_per_share"
    t.decimal  "day_high_price"
    t.decimal  "day_low_price"
    t.decimal  "book_value"
    t.decimal  "price_to_book_ratio"
    t.decimal  "price_to_earnings_ratio"
    t.decimal  "year_low_price"
    t.decimal  "year_high_price"
  end

end
