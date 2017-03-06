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

ActiveRecord::Schema.define(version: 20170305233856) do

  create_table "camp_sessions", force: :cascade do |t|
    t.string   "name"
    t.integer  "capacity"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "year"
    t.integer  "remaining"
    t.integer  "gender"
    t.decimal  "fee",         precision: 8, scale: 2
    t.integer  "minimum_age"
    t.integer  "maximum_age"
    t.boolean  "enabled"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "camper_submissions", force: :cascade do |t|
    t.integer  "submission_id"
    t.integer  "camp_session_id"
    t.integer  "camper_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["camp_session_id"], name: "index_camper_submissions_on_camp_session_id"
    t.index ["camper_id"], name: "index_camper_submissions_on_camper_id"
    t.index ["submission_id"], name: "index_camper_submissions_on_submission_id"
  end

  create_table "campers", force: :cascade do |t|
    t.integer  "camp_session_id"
    t.integer  "registration_cart_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.text     "address"
    t.datetime "birth_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "parent_id"
    t.index ["camp_session_id"], name: "index_campers_on_camp_session_id"
    t.index ["parent_id"], name: "index_campers_on_parent_id"
    t.index ["registration_cart_id"], name: "index_campers_on_registration_cart_id"
  end

  create_table "parents", force: :cascade do |t|
    t.integer  "registration_cart_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "email"
    t.string   "home_phone_number"
    t.string   "cell_phone_number"
    t.string   "work_phone_number"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["registration_cart_id"], name: "index_parents_on_registration_cart_id"
  end

  create_table "registration_carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.string   "charge_id"
    t.decimal  "amount_paid", precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "parent_id"
    t.index ["parent_id"], name: "index_submissions_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
