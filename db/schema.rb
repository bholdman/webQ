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

ActiveRecord::Schema.define(:version => 20121024011014) do

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "assets", ["attachable_id", "attachable_type"], :name => "index_assets_on_attachable_id_and_attachable_type"

  create_table "assignments", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.boolean  "isOwner"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attachments", :force => true do |t|
    t.text     "description"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"

  create_table "departments", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "prefix",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.integer  "upload_id"
    t.text     "body"
    t.integer  "internal",   :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ticket_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.boolean  "isCreator"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.integer  "department_id",           :null => false
    t.integer  "upload_id",               :null => false
    t.string   "subject",                 :null => false
    t.text     "body",                    :null => false
    t.string   "status_id",               :null => false
    t.text     "url",                     :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "tickets", ["subject"], :name => "subject"

  create_table "uploads", :force => true do |t|
    t.integer  "ticket_id"
    t.string   "upload_file_name",    :null => false
    t.string   "upload_content_type", :null => false
    t.integer  "upload_file_size",    :null => false
    t.datetime "upload_updated_at",   :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "fName",         :null => false
    t.string   "lName",         :null => false
    t.string   "seKey",         :null => false
    t.integer  "department_id", :null => false
    t.boolean  "isAdmin"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "auth_token"
  end

end
