# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160424192517) do

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "notification", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "notification", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notification", ["user_id"], name: "index_notification_on_user_id", using: :btree

  create_table "order_details", id: false, force: :cascade do |t|
    t.string   "item",       limit: 255
    t.integer  "price",      limit: 4
    t.integer  "amount",     limit: 4
    t.string   "comment",    limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "order_details", ["item"], name: "index_order_details_on_item", using: :btree
  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["user_id"], name: "index_order_details_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "image",               limit: 255
    t.integer  "for",                 limit: 4
    t.string   "from",                limit: 255
    t.integer  "status",              limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "orders_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "order_id",   limit: 4
    t.boolean  "is_joined",            default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "orders_users", ["order_id"], name: "index_orders_users_on_order_id", using: :btree
  add_index "orders_users", ["user_id"], name: "index_orders_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255,              null: false
    t.string   "imag",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "groups", "users"
  add_foreign_key "notification", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "orders_users", "orders"
  add_foreign_key "orders_users", "users"
end
