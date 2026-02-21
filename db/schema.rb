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

ActiveRecord::Schema[8.1].define(version: 2026_02_21_042127) do
  create_table "branches", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.datetime "created_at", null: false
    t.integer "product_variant_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_inventories_on_branch_id"
    t.index ["product_variant_id"], name: "index_inventories_on_product_variant_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.string "material"
    t.decimal "price"
    t.integer "product_id", null: false
    t.string "size"
    t.string "sku"
    t.integer "stock", default: 0
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.boolean "active", default: true
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 1, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "inventories", "branches"
  add_foreign_key "inventories", "product_variants"
  add_foreign_key "product_variants", "products"
  add_foreign_key "products", "users"
end
