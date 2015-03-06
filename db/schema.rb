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

ActiveRecord::Schema.define(version: 20150307134818) do

  create_table "packages", force: :cascade do |t|
    t.string   "name",                       null: false
    t.integer  "user_id",                    null: false
    t.text     "description"
    t.text     "readme"
    t.text     "readme_html"
    t.string   "homepage"
    t.string   "repository"
    t.string   "license"
    t.integer  "download_count", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "packages", ["name"], name: "index_packages_on_name", unique: true
  add_index "packages", ["user_id"], name: "index_packages_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "name",             null: false
    t.string   "token"
    t.datetime "deleted_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "version",              null: false
    t.string   "archive_file_name",    null: false
    t.string   "archive_content_type", null: false
    t.integer  "archive_file_size",    null: false
    t.datetime "archive_updated_at",   null: false
    t.integer  "package_id",           null: false
    t.datetime "deleted_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "versions", ["package_id"], name: "index_versions_on_package_id"

end
