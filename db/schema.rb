# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_08_102654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "series", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.integer "episodes_count"
    t.integer "genre"
    t.date "release_date"
    t.integer "seasons_count"
    t.integer "status"
    t.text "synopsis"
    t.string "title"
    t.jsonb "titles"
    t.integer "total_episodes"
    t.datetime "updated_at", null: false
    t.integer "view_count"
    t.integer "year"
    t.index ["genre"], name: "index_series_on_genre"
    t.index ["release_date"], name: "index_series_on_release_date"
    t.index ["status"], name: "index_series_on_status"
    t.index ["year"], name: "index_series_on_year"
  end

  create_table "users", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.boolean "email_verified", default: false
    t.string "otp_code"
    t.datetime "otp_expires_at"
    t.string "password_digest", null: false
    t.datetime "password_reset_sent_at"
    t.string "password_reset_token"
    t.string "phone_number"
    t.integer "role", default: 0
    t.bigint "subscription_id"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["otp_code"], name: "index_users_on_otp_code"
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true
    t.index ["subscription_id"], name: "index_users_on_subscription_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end
end
