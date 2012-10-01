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

ActiveRecord::Schema.define(:version => 20121001101551) do

  create_table "applications", :force => true do |t|
    t.integer  "project_id"
    t.string   "product_name"
    t.string   "bundle_identifier"
    t.float    "bundle_version",    :default => 1.0
    t.string   "relative_path"
    t.string   "title"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "clients", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "email"
    t.string   "handle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.integer  "manager_id"
    t.string   "email"
    t.string   "personal_email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "developers_projects", :id => false, :force => true do |t|
    t.integer "developer_id"
    t.integer "project_id"
  end

  add_index "developers_projects", ["developer_id", "project_id"], :name => "index_developers_projects_on_developer_id_and_project_id"
  add_index "developers_projects", ["project_id", "developer_id"], :name => "index_developers_projects_on_project_id_and_developer_id"

  create_table "handles", :force => true do |t|
    t.integer  "client_id"
    t.string   "handle_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "managers", :force => true do |t|
    t.string   "name"
    t.string   "personal_email"
    t.string   "office_email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "client_id"
    t.integer  "manager_id"
    t.string   "name"
    t.string   "svn"
    t.string   "handle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
