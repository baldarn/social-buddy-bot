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

ActiveRecord::Schema[7.0].define(version: 2023_05_22_194735) do
  create_table "chat_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chat_type"
    t.string "platform_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name"
    t.index ["chat_type", "platform_id"], name: "index_chat_users_on_chat_type_and_platform_id", unique: true
    t.index ["user_id"], name: "index_chat_users_on_user_id"
  end

  create_table "configs", force: :cascade do |t|
    t.integer "user_id"
    t.string "slack_api_key"
    t.string "discord_api_key"
    t.string "slack_relax_channel"
    t.string "discord_relax_channel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "open_ai_secret"
    t.boolean "event_coffee_1_enabled", default: true
    t.boolean "event_coffee_2_enabled", default: true
    t.boolean "event_lunch_enabled", default: true
    t.boolean "event_walk_enabled", default: true
    t.boolean "event_game_enabled", default: true
    t.integer "event_coffee_1_time", default: 1000
    t.integer "event_coffee_2_time", default: 1500
    t.integer "event_lunch_time", default: 1230
    t.integer "event_walk_time", default: 1600
    t.integer "event_game_time", default: 1730
    t.index ["user_id"], name: "index_configs_on_user_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.integer "chat_user_id"
    t.integer "chat_type"
    t.string "platform_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_type", "platform_id"], name: "index_interactions_on_chat_type_and_platform_id", unique: true
    t.index ["chat_user_id"], name: "index_interactions_on_chat_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chat_users", "users"
  add_foreign_key "configs", "users"
  add_foreign_key "interactions", "chat_users"
end
