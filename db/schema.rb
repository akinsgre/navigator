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

ActiveRecord::Schema.define(version: 20141205124848) do

  create_table "ad_histories", force: true do |t|
    t.integer  "sponsor_id"
    t.text     "message"
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "advertisements", force: true do |t|
    t.integer  "sponsor_id"
    t.text     "message"
    t.text     "html_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "phone_message"
  end

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "type"
    t.string   "entry"
    t.string   "identifier"
    t.text     "normalized_entry"
  end

  create_table "contributions", force: true do |t|
    t.integer  "group_id"
    t.integer  "sponsor_id"
    t.decimal  "amount",     precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_contacts", force: true do |t|
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_sponsors", force: true do |t|
    t.integer  "group_id"
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "description"
    t.string   "sponsor_email"
    t.integer  "membership_level_id"
    t.text     "twilio_number"
  end

  create_table "invites", force: true do |t|
    t.text     "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "membership_levels", force: true do |t|
    t.integer  "allowed_messages"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "allowed_contacts"
  end

  add_index "membership_levels", ["name"], name: "index_membership_levels_on_name", unique: true

  create_table "messages", force: true do |t|
    t.string   "message"
    t.string   "address"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "phone_message"
    t.text     "html_message"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",           default: false
    t.integer  "messages_sent",    default: 0
    t.integer  "messages_allowed", default: 0
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
