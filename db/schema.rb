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

ActiveRecord::Schema.define(:version => 20130522103843) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "employee"
    t.string   "password"
    t.string   "salt"
    t.string   "position"
    t.integer  "company_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "employees", ["company_id"], :name => "index_employees_on_company_id"

  create_table "hotelsupplies", :force => true do |t|
    t.string   "name"
    t.integer  "num"
    t.integer  "cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hotelsuppliesrequests", :force => true do |t|
    t.integer  "num"
    t.integer  "stationeryrequest_id"
    t.integer  "hotelsupply_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "hotelsuppliesrequests", ["hotelsupply_id"], :name => "index_hotelsuppliesrequests_on_hotelsupply_id"
  add_index "hotelsuppliesrequests", ["stationeryrequest_id"], :name => "index_hotelsuppliesrequests_on_stationeryrequest_id"

  create_table "measures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stationeryrequests", :force => true do |t|
    t.integer  "status"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "stationeryrequests", ["employee_id"], :name => "index_stationeryrequests_on_employee_id"

  create_table "taxirequests", :force => true do |t|
    t.integer  "order_number"
    t.string   "payment_method"
    t.integer  "cost"
    t.integer  "room"
    t.string   "destination"
    t.date     "arrival_date"
    t.time     "arrival_time"
    t.string   "guest_name"
    t.integer  "employee_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "status",         :default => 0
  end

  add_index "taxirequests", ["employee_id"], :name => "index_taxirequests_on_employee_id"

end
