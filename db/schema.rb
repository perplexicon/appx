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

ActiveRecord::Schema.define(version: 20140924035409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "feed_entries", force: true do |t|
    t.string   "name"
    t.text     "content",      null: false
    t.string   "url",          null: false
    t.datetime "published_at", null: false
    t.string   "guid",         null: false
    t.integer  "source_id",    null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_entries", ["source_id"], name: "index_feed_entries_on_source_id", using: :btree
  add_index "feed_entries", ["user_id"], name: "index_feed_entries_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "sources", force: true do |t|
    t.string   "etag",          null: false
    t.string   "name",          null: false
    t.string   "url",           null: false
    t.string   "feed_url",      null: false
    t.time     "last_modified", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  add_index "sources", ["user_id"], name: "index_sources_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
