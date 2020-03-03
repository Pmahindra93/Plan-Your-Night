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
ActiveRecord::Schema.define(version: 2020_03_03_101207) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favourites_on_user_id"
    t.index ["venue_id"], name: "index_favourites_on_venue_id"
  end

  create_table "night_venues", force: :cascade do |t|
    t.bigint "venue_id"
    t.bigint "night_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["night_id"], name: "index_night_venues_on_night_id"
    t.index ["venue_id"], name: "index_night_venues_on_venue_id"
  end

  create_table "nights", force: :cascade do |t|
    t.bigint "user_id"
    t.string "total_price_segment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nights_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venue_reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "venue_id"
    t.text "content"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_venue_reviews_on_user_id"
    t.index ["venue_id"], name: "index_venue_reviews_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "venue_type"
    t.string "category"
    t.string "name"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.string "opening_hours"
    t.string "price_segment"
    t.boolean "card_accepted"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favourites", "users"
  add_foreign_key "favourites", "venues"
  add_foreign_key "night_venues", "nights"
  add_foreign_key "night_venues", "venues"
  add_foreign_key "nights", "users"
  add_foreign_key "venue_reviews", "users"
  add_foreign_key "venue_reviews", "venues"
end
