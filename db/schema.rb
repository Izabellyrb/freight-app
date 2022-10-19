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

ActiveRecord::Schema[7.0].define(version: 2022_10_19_112325) do
  create_table "deadlines", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "time"
    t.integer "transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_id"], name: "index_deadlines_on_transport_id"
  end

  create_table "distance_prices", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.decimal "value_km"
    t.integer "transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_id"], name: "index_distance_prices_on_transport_id"
  end

  create_table "end_service_orders", force: :cascade do |t|
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_order_id", null: false
    t.index ["service_order_id"], name: "index_end_service_orders_on_service_order_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "sender_address"
    t.string "sender_name"
    t.string "receiver_address"
    t.string "receiver_name"
    t.string "product_code"
    t.integer "product_width"
    t.integer "product_height"
    t.string "order_code"
    t.integer "order_weight"
    t.integer "order_distance"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "start_service_orders", force: :cascade do |t|
    t.integer "transport_id", null: false
    t.integer "service_order_id", null: false
    t.integer "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_order_id"], name: "index_start_service_orders_on_service_order_id"
    t.index ["transport_id"], name: "index_start_service_orders_on_transport_id"
    t.index ["vehicle_id"], name: "index_start_service_orders_on_vehicle_id"
  end

  create_table "transports", force: :cascade do |t|
    t.string "name"
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "min_weight"
    t.integer "max_weight"
    t.integer "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "function", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "make"
    t.string "model"
    t.integer "year"
    t.integer "max_load_capacity"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weight_prices", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "value_km"
    t.integer "transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_id"], name: "index_weight_prices_on_transport_id"
  end

  add_foreign_key "deadlines", "transports"
  add_foreign_key "distance_prices", "transports"
  add_foreign_key "end_service_orders", "service_orders"
  add_foreign_key "start_service_orders", "service_orders"
  add_foreign_key "start_service_orders", "transports"
  add_foreign_key "start_service_orders", "vehicles"
  add_foreign_key "weight_prices", "transports"
end
