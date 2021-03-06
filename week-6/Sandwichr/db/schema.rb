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

ActiveRecord::Schema.define(version: 20160502132453) do

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.integer  "calories",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount",     default: 0.0
  end

  create_table "sandwich_ingredients", force: :cascade do |t|
    t.integer  "sandwich_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sandwich_ingredients", ["ingredient_id"], name: "index_sandwich_ingredients_on_ingredient_id"
  add_index "sandwich_ingredients", ["sandwich_id"], name: "index_sandwich_ingredients_on_sandwich_id"

  create_table "sandwiches", force: :cascade do |t|
    t.string   "name"
    t.string   "bread_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_calories", default: 0
  end

end
