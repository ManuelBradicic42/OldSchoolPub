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

ActiveRecord::Schema.define(version: 2020_11_24_135215) do

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.boolean "availability"
    t.float "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus_orders", id: false, force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "order_id", null: false
    t.index ["menu_id", "order_id"], name: "index_menus_orders_on_menu_id_and_order_id"
    t.index ["order_id", "menu_id"], name: "index_menus_orders_on_order_id_and_menu_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "orderNr", null: false
    t.date "date", null: false
    t.string "customerName", null: false
    t.string "customerNumber", null: false
    t.text "address", null: false
    t.integer "totalPrice", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
