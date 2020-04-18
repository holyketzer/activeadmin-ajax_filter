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

ActiveRecord::Schema.define(version: 2020_04_18_135023) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "subcategory_id", null: false
    t.index ["subcategory_id"], name: "index_items_on_subcategory_id"
  end

  create_table "items_tags", id: false, force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "tag_id", null: false
    t.index ["item_id", "tag_id"], name: "index_items_tags_on_item_id_and_tag_id"
    t.index ["tag_id", "item_id"], name: "index_items_tags_on_tag_id_and_item_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.integer "subcategory_id", null: false
    t.index ["subcategory_id"], name: "index_tags_on_subcategory_id"
  end

end
