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

ActiveRecord::Schema[8.1].define(version: 2026_01_15_073351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "couple_users", force: :cascade do |t|
    t.bigint "couple_id", null: false
    t.datetime "created_at", null: false
    t.string "partner_nickname", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["couple_id", "user_id"], name: "index_couple_users_on_couple_id_and_user_id", unique: true
    t.index ["couple_id"], name: "index_couple_users_on_couple_id"
    t.index ["user_id"], name: "index_couple_users_on_user_id"
  end

  create_table "couples", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "couple_id"
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.bigint "inviter_id", null: false
    t.datetime "updated_at", null: false
    t.datetime "used_at"
    t.index ["code"], name: "index_invitations_on_code", unique: true
    t.index ["couple_id"], name: "index_invitations_on_couple_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "couple_users", "couples"
  add_foreign_key "couple_users", "users"
  add_foreign_key "invitations", "couples"
  add_foreign_key "invitations", "users", column: "inviter_id"
end
