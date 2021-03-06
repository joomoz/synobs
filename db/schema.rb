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

ActiveRecord::Schema.define(version: 20170514151703) do

  create_table "daily_observations", force: :cascade do |t|
    t.integer  "observation_station_id"
    t.date     "date"
    t.float    "t2max"
    t.datetime "t2maxtime"
    t.float    "t2min"
    t.datetime "t2mintime"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "favourite_stations", force: :cascade do |t|
    t.integer  "observation_station_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "observation_stations", force: :cascade do |t|
    t.integer  "lpnn"
    t.integer  "wmo"
    t.string   "name"
    t.integer  "year"
    t.float    "lat"
    t.float    "lon"
    t.integer  "elevation"
    t.string   "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "observations", force: :cascade do |t|
    t.integer  "observation_station_id"
    t.datetime "time"
    t.float    "t2m"
    t.float    "td"
    t.float    "ws_10min"
    t.float    "wg_10min"
    t.float    "wd_10min"
    t.float    "rh"
    t.float    "r_1h"
    t.float    "ri_10min"
    t.float    "snow_aws"
    t.float    "p_sea"
    t.float    "vis"
    t.float    "n"
    t.float    "wawa"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
