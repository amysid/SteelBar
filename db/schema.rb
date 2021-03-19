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

ActiveRecord::Schema.define(version: 2021_03_06_102215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coatings", force: :cascade do |t|
    t.string "coating"
    t.string "coating_type"
    t.integer "cost_per_sqm"
    t.integer "reading"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_premia", force: :cascade do |t|
    t.integer "number_entered"
    t.integer "custom_premium_per_mt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_panel_details", force: :cascade do |t|
    t.integer "grade"
    t.string "surface"
    t.integer "profit"
    t.bigint "customer_panel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_panel_id"], name: "index_customer_panel_details_on_customer_panel_id"
  end

  create_table "customer_panels", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "container_loading_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.string "name"
    t.string "source"
    t.string "grade"
    t.string "classification"
    t.string "surface"
    t.string "thick"
    t.string "width"
    t.string "edge"
    t.string "length"
    t.string "package_wt"
    t.string "coating"
    t.string "coating_type"
    t.string "quantity_mt"
    t.string "custom_premium"
    t.string "port"
    t.string "unit_price"
    t.string "usd_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "general_panels", force: :cascade do |t|
    t.integer "tax_ref"
    t.integer "exch_rate"
    t.integer "local_transportation_cost"
    t.integer "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "length_edges", force: :cascade do |t|
    t.string "source"
    t.integer "grade"
    t.integer "length_cost_add"
    t.integer "edge_cost_add"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pods", force: :cascade do |t|
    t.string "export_pod"
    t.integer "container_cost_add"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_lists", force: :cascade do |t|
    t.integer "grade"
    t.string "surface"
    t.integer "min_thickness_in_mm"
    t.integer "max_thickness_in_mm"
    t.integer "width"
    t.string "package"
    t.integer "base_price"
    t.integer "additional_cost"
    t.integer "price"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_price_lists_on_supplier_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: ""
    t.string "password_digest", default: ""
    t.string "verificatin_link", default: ""
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surfaces", force: :cascade do |t|
    t.integer "grade"
    t.string "surface"
    t.string "surface_type"
    t.integer "cost"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: ""
    t.string "mobile", default: ""
    t.integer "gender", default: 0
    t.integer "role", default: 1
    t.string "address", default: ""
    t.string "password_digest", default: ""
    t.string "verificatin_link", default: ""
    t.string "image"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_panel_details", "customer_panels"
  add_foreign_key "price_lists", "suppliers"
end
