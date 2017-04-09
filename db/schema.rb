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

ActiveRecord::Schema.define(version: 20170409221902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "saved_things", force: :cascade do |t|
    t.string   "type"
    t.string   "reddit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json     "payload"
  end

  create_table "user_saved_things", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "saved_thing_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["saved_thing_id"], name: "index_user_saved_things_on_saved_thing_id", using: :btree
    t.index ["user_id"], name: "index_user_saved_things_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "access_token"
  end

  add_foreign_key "user_saved_things", "saved_things"
  add_foreign_key "user_saved_things", "users"
end
