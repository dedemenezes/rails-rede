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

ActiveRecord::Schema[7.0].define(version: 2023_03_05_165617) do
  # These are extensions that must be enabled in order to support this database
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

  create_table "articles", force: :cascade do |t|
    t.string "header"
    t.string "sub_header"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "highlight"
    t.boolean "featured", default: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conflict_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["project_id"], name: "index_methodologies_on_project_id"
  end

  create_table "observatories", force: :cascade do |t|
    t.string "headline"
    t.string "name"
    t.string "description"
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
    t.index ["unity_type_id"], name: "index_observatories_on_unity_type_id"
  end

  create_table "observatory_categories", force: :cascade do |t|
    t.bigint "observatory_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_observatory_categories_on_category_id"
    t.index ["observatory_id"], name: "index_observatory_categories_on_observatory_id"
  end

  create_table "observatory_conflicts", force: :cascade do |t|
    t.bigint "observatory_id", null: false
    t.bigint "conflict_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conflict_type_id"], name: "index_observatory_conflicts_on_conflict_type_id"
    t.index ["observatory_id"], name: "index_observatory_conflicts_on_observatory_id"
  end

  create_table "observatory_priorities", force: :cascade do |t|
    t.bigint "observatory_id", null: false
    t.bigint "priority_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["observatory_id"], name: "index_observatory_priorities_on_observatory_id"
    t.index ["priority_type_id"], name: "index_observatory_priorities_on_priority_type_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "members", "observatories"
  add_foreign_key "members", "projects"
  add_foreign_key "methodologies", "projects"
  add_foreign_key "observatories", "unity_types"
  add_foreign_key "observatory_categories", "categories"
  add_foreign_key "observatory_categories", "observatories"
  add_foreign_key "observatory_conflicts", "conflict_types"
  add_foreign_key "observatory_conflicts", "observatories"
  add_foreign_key "observatory_priorities", "observatories"
  add_foreign_key "observatory_priorities", "priority_types"
end
