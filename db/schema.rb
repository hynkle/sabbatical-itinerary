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

ActiveRecord::Schema.define(version: 20140223152022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: true do |t|
    t.string  "ident"
    t.string  "name"
    t.string  "city"
    t.string  "size"
    t.string  "keywords"
    t.boolean "scheduled_service"
    t.float   "lat"
    t.float   "lon"
    t.string  "iata_code"
    t.string  "local_code"
  end

  add_index "airports", ["ident"], name: "index_airports_on_ident", using: :btree
  add_index "airports", ["scheduled_service"], name: "index_airports_on_scheduled_service", using: :btree

  create_table "currencies", force: true do |t|
    t.string   "iso_code"
    t.string   "name"
    t.string   "format",         default: "%{amount} %{iso_code}"
    t.integer  "decimal_digits", default: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.string   "from"
    t.datetime "date"
    t.string   "subject"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flights", force: true do |t|
    t.integer  "flight_id"
    t.datetime "departure_local"
    t.datetime "arrival_local"
    t.datetime "departure_utc"
    t.datetime "arrival_utc"
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lodgings", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plane_journeys", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stays", force: true do |t|
    t.integer  "lodging_id"
    t.date     "checkin"
    t.date     "checkout"
    t.boolean  "booked"
    t.boolean  "paid"
    t.decimal  "cost",        precision: 7, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
  end

end
