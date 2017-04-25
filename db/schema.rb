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

ActiveRecord::Schema.define(version: 20170303133802) do

  create_table "ports", force: :cascade do |t|
    t.string   "title"
    t.string   "target"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vullevels", force: :cascade do |t|
    t.string   "levelname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vuls", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "description"
    t.integer  "type_id"
    t.integer  "level_id"
    t.string   "search_key"
    t.string   "file"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "format"
    t.index ["level_id"], name: "index_vuls_on_level_id"
    t.index ["type_id"], name: "index_vuls_on_type_id"
    t.index ["user_id", "created_at"], name: "index_vuls_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_vuls_on_user_id"
  end

  create_table "vultypes", force: :cascade do |t|
    t.string   "typename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
