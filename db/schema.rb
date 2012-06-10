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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120311135341) do

  create_table "assistances", :force => true do |t|
    t.integer  "family_help_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_id"
  end

  create_table "children", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "family_id"
    t.integer  "health_id"
    t.integer  "age"
    t.integer  "study_id"
    t.text     "description"
    t.string   "phone"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "families", :force => true do |t|
    t.string   "title"
    t.string   "phone"
    t.integer  "city_id"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "home_id"
    t.integer  "source_id"
    t.integer  "resource_id"
    t.text     "description"
    t.integer  "priority"
    t.integer  "source_amount"
  end

  create_table "family_helps", :force => true do |t|
    t.text     "description"
    t.integer  "amount"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_id"
    t.date     "made_at"
    t.integer  "help_type_id"
  end

  create_table "family_necessities", :force => true do |t|
    t.integer  "family_id"
    t.integer  "necessity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fathers", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "family_id"
    t.integer  "health_id"
    t.integer  "age"
    t.text     "description"
    t.string   "phone"
  end

  create_table "group_options", :force => true do |t|
    t.string   "name"
    t.integer  "coeff"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount_start"
    t.integer  "amount_end"
  end

  add_index "group_options", ["group_id"], :name => "index_group_options_on_group_id"

  create_table "groups", :force => true do |t|
    t.string   "groupName"
    t.integer  "groupCoeff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "help_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "help_users", :force => true do |t|
    t.integer  "family_help_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mothers", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "family_id"
    t.integer  "health_id"
    t.integer  "age"
    t.text     "description"
    t.string   "phone"
  end

  create_table "necessities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "study_categories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "trusties", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.string   "who"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "family_id"
    t.integer  "health_id"
    t.integer  "age"
    t.text     "description"
    t.string   "phone"
  end

  create_table "user_roles", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "profession"
    t.text     "description"
    t.integer  "city_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_families", :force => true do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "visit_date"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "made_at"
  end

end
