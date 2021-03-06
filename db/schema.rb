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

ActiveRecord::Schema.define(version: 20170402200820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_profiles", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.integer "admin_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "active_status"
  end

  create_table "companies_employee_profiles", id: false, force: :cascade do |t|
    t.integer "company_id"
    t.integer "employee_profile_id"
    t.index ["company_id"], name: "index_companies_employee_profiles_on_company_id"
    t.index ["employee_profile_id"], name: "index_companies_employee_profiles_on_employee_profile_id"
  end

  create_table "employee_profiles", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", id: :serial, force: :cascade do |t|
    t.integer "pay_cents"
    t.integer "pay_type"
    t.integer "employee_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "pay_freq"
    t.integer "company_id"
    t.integer "active_status"
    t.index ["company_id"], name: "index_jobs_on_company_id"
    t.index ["employee_profile_id"], name: "index_jobs_on_employee_profile_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "read_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.index ["recipient_id"], name: "index_messages_on_recipient_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "pay_periods", id: :serial, force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.date "pay_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_id"
    t.text "notes"
    t.index ["job_id"], name: "index_pay_periods_on_job_id"
  end

  create_table "timesheets", id: :serial, force: :cascade do |t|
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.integer "approved_status"
    t.integer "approving_admin_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pay_period_id"
    t.index ["pay_period_id"], name: "index_timesheets_on_pay_period_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "username", null: false
    t.string "profileable_type"
    t.integer "profileable_id"
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "full_name"
    t.integer "active_status"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.index ["profileable_type", "profileable_id"], name: "index_users_on_profileable_type_and_profileable_id"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
