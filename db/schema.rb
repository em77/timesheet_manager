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

ActiveRecord::Schema.define(version: 20161222181657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "admin_profile_id"
    t.integer  "pay_freq"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "title"
  end

  create_table "employee_profiles", force: :cascade do |t|
    t.integer  "active_status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "admin_profile_id"
    t.integer  "employee_profile_id"
    t.text     "content"
    t.integer  "read_status"
    t.integer  "sender_user_id"
    t.integer  "recipient_user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "subject"
    t.index ["admin_profile_id"], name: "index_messages_on_admin_profile_id", using: :btree
    t.index ["employee_profile_id"], name: "index_messages_on_employee_profile_id", using: :btree
  end

  create_table "pay_periods", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "pay_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.integer  "approved_status"
    t.integer  "approving_admin_profile_id"
    t.integer  "pay_period_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["pay_period_id"], name: "index_timesheets_on_pay_period_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username",                     null: false
    t.string   "profileable_type"
    t.integer  "profileable_id"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["profileable_type", "profileable_id"], name: "index_users_on_profileable_type_and_profileable_id", using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  end

end
