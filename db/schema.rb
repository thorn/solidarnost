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

ActiveRecord::Schema.define(:version => 20130318111210) do

  create_table "assistances", :force => true do |t|
    t.integer  "family_help_id"
    t.integer  "user_id"
    t.integer  "visit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.text     "description"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"

  create_table "children", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "health_id"
    t.integer  "family_id"
    t.integer  "age"
    t.integer  "study_id"
    t.text     "description"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sex"
    t.integer  "working"
    t.string   "profession"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.string   "aoguid"
    t.string   "prefix"
  end

  create_table "coefficients", :force => true do |t|
    t.integer  "coefficientable_id"
    t.string   "coefficientable_type"
    t.integer  "group_option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dictionaries", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "families", :force => true do |t|
    t.string   "title"
    t.string   "phone"
    t.integer  "city_id"
    t.string   "address"
    t.integer  "home_id"
    t.integer  "source_id"
    t.integer  "resource_id"
    t.text     "description"
    t.integer  "priority"
    t.integer  "source_amount"
    t.date     "debt_time"
    t.integer  "debt_amount"
    t.integer  "credit_time"
    t.integer  "credit_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "children_counter", :default => 0
    t.integer  "member_counter",   :default => 0
    t.integer  "mother_counter",   :default => 0
    t.integer  "father_counter",   :default => 0
    t.integer  "status",           :default => 1
    t.integer  "area_id"
  end

  create_table "family_help_funds", :force => true do |t|
    t.integer  "family_help_id"
    t.integer  "fund_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "family_helps", :force => true do |t|
    t.text     "description"
    t.integer  "amount"
    t.integer  "family_id"
    t.integer  "visit_id"
    t.date     "made_at"
    t.integer  "help_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "family_members", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "health_id"
    t.integer  "family_id"
    t.integer  "age"
    t.integer  "study_id"
    t.text     "description"
    t.boolean  "sex"
    t.string   "phone"
    t.integer  "family_member_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "working"
    t.string   "profession"
  end

  create_table "family_necessities", :force => true do |t|
    t.integer  "family_id"
    t.integer  "necessity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fathers", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "health_id"
    t.integer  "family_id"
    t.integer  "age"
    t.text     "description"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "working"
    t.string   "profession"
  end

  create_table "group_options", :force => true do |t|
    t.string   "name"
    t.integer  "coeff"
    t.integer  "group_id"
    t.integer  "amount_start"
    t.integer  "amount_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "problem",      :default => false
    t.boolean  "trouble"
  end

  add_index "group_options", ["group_id"], :name => "index_group_options_on_group_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "coeff",      :default => 0
    t.boolean  "for_people", :default => false
    t.boolean  "important",  :default => true
    t.integer  "setting_id"
    t.integer  "position"
    t.boolean  "hidden"
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
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "health_id"
    t.integer  "family_id"
    t.integer  "age"
    t.text     "description"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "working"
    t.string   "profession"
  end

  create_table "necessities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.text     "text"
    t.string   "title"
    t.integer  "news_type"
    t.integer  "status",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "group_name"
    t.string   "name"
    t.integer  "start"
    t.integer  "end"
    t.text     "value"
    t.integer  "amount"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "amount"
    t.integer  "setting_id"
    t.integer  "family_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trusties", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "health_id"
    t.string   "who"
    t.integer  "family_id"
    t.integer  "age"
    t.text     "description"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "working"
    t.string   "profession"
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
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "profession"
    t.text     "description"
    t.integer  "city_id"
    t.integer  "fund_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_families", :force => true do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visit_funds", :force => true do |t|
    t.integer  "fund_id"
    t.integer  "visit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "visit_date"
    t.integer  "family_id"
    t.date     "made_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
