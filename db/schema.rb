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

ActiveRecord::Schema[7.0].define(version: 2025_07_24_183124) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "albums", force: :cascade do |t|
    t.bigint "gallery_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_event", default: false
    t.date "event_date"
    t.boolean "published", default: false
    t.string "category"
    t.boolean "main_featured", default: false
    t.index ["gallery_id"], name: "index_albums_on_gallery_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "header"
    t.string "sub_header"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "highlight"
    t.boolean "featured", default: false
    t.boolean "published", default: false
    t.bigint "observatory_id"
    t.bigint "methodology_id"
    t.bigint "project_id"
    t.string "banner_subtitle"
    t.datetime "featured_at"
    t.boolean "main_featured", default: false
    t.index ["methodology_id"], name: "index_articles_on_methodology_id"
    t.index ["observatory_id"], name: "index_articles_on_observatory_id"
    t.index ["project_id"], name: "index_articles_on_project_id"
  end

  create_table "conflict_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_conflict_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.string "name"
    t.bigint "observatory_id"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false
    t.bigint "methodology_id"
    t.boolean "is_event", default: false
    t.date "event_date"
    t.index ["methodology_id"], name: "index_galleries_on_methodology_id"
    t.index ["observatory_id"], name: "index_galleries_on_observatory_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "occupation"
    t.string "role"
    t.boolean "published"
    t.bigint "observatory_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["observatory_id"], name: "index_members_on_observatory_id"
    t.index ["project_id"], name: "index_members_on_project_id"
  end

  create_table "methodologies", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "header_one"
    t.text "description_one"
    t.string "header_two"
    t.text "description_two"
    t.boolean "published", default: false
    t.string "card_description"
    t.index ["project_id"], name: "index_methodologies_on_project_id"
  end

  create_table "observatories", force: :cascade do |t|
    t.string "headline"
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "type"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unity_type_id", null: false
    t.string "street"
    t.string "number"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "neighborhood"
    t.string "municipality"
    t.text "description"
    t.index ["unity_type_id"], name: "index_observatories_on_unity_type_id"
  end

  create_table "observatory_conflicts", force: :cascade do |t|
    t.bigint "observatory_id", null: false
    t.bigint "conflict_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conflict_type_id"], name: "index_observatory_conflicts_on_conflict_type_id"
    t.index ["observatory_id"], name: "index_observatory_conflicts_on_observatory_id"
  end

  create_table "observatory_priority_subjects", force: :cascade do |t|
    t.bigint "priority_type_id", null: false
    t.bigint "observatory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["observatory_id"], name: "index_observatory_priority_subjects_on_observatory_id"
    t.index ["priority_type_id"], name: "index_observatory_priority_subjects_on_priority_type_id"
  end

  create_table "priority_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "banner_text"
    t.string "slide_one_subtitle"
    t.string "slide_two_subtitle"
    t.string "slide_three_subtitle"
    t.string "video_id"
    t.string "yt_url"
    t.string "fb_url"
    t.string "ig_url"
    t.string "email"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: false, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tilesets", force: :cascade do |t|
    t.string "name"
    t.string "mapbox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mapbox_owner"
    t.json "geo_json", default: {}
  end

  create_table "unity_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.boolean "staff", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "url", null: false
    t.string "yt_id"
    t.string "yt_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false, null: false
    t.string "name"
    t.string "description"
    t.bigint "album_id"
    t.index ["album_id"], name: "index_videos_on_album_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "albums", "galleries"
  add_foreign_key "articles", "methodologies"
  add_foreign_key "articles", "observatories"
  add_foreign_key "articles", "projects"
  add_foreign_key "galleries", "methodologies"
  add_foreign_key "galleries", "observatories"
  add_foreign_key "members", "observatories"
  add_foreign_key "members", "projects"
  add_foreign_key "methodologies", "projects"
  add_foreign_key "observatories", "unity_types"
  add_foreign_key "observatory_conflicts", "conflict_types"
  add_foreign_key "observatory_conflicts", "observatories"
  add_foreign_key "observatory_priority_subjects", "observatories"
  add_foreign_key "observatory_priority_subjects", "priority_types"
  add_foreign_key "taggings", "tags"
  add_foreign_key "videos", "albums"
end
