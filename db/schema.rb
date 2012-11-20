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

ActiveRecord::Schema.define(:version => 20121120114310) do

  create_table "ambassadors", :force => true do |t|
    t.integer  "college_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "ambassador_manager_id"
  end

  add_index "ambassadors", ["college_id"], :name => "index_ambassadors_on_college_id"

  create_table "book_apis", :force => true do |t|
    t.string   "book"
    t.string   "author"
    t.string   "isbn"
    t.string   "isbn13"
    t.string   "binding"
    t.string   "publishing_date"
    t.string   "publisher"
    t.string   "edition"
    t.integer  "number_of_pages"
    t.string   "language"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "image_url"
  end

  create_table "book_carts", :force => true do |t|
    t.integer  "book_id"
    t.integer  "cart_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "book_colleges", :force => true do |t|
    t.integer  "book_id"
    t.integer  "college_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "book_colleges", ["book_id"], :name => "index_book_colleges_on_book_id"
  add_index "book_colleges", ["college_id"], :name => "index_book_colleges_on_college_id"

  create_table "book_orders", :force => true do |t|
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "book_orders", ["book_id"], :name => "index_book_orders_on_book_id"
  add_index "book_orders", ["order_id"], :name => "index_book_orders_on_order_id"

  create_table "book_semesters", :force => true do |t|
    t.integer  "book_id"
    t.integer  "semester_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "book_semesters", ["book_id"], :name => "index_book_semesters_on_book_id"
  add_index "book_semesters", ["semester_id"], :name => "index_book_semesters_on_semester_id"

  create_table "book_streams", :force => true do |t|
    t.integer  "book_id"
    t.integer  "stream_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "book_streams", ["book_id"], :name => "index_book_streams_on_book_id"
  add_index "book_streams", ["stream_id"], :name => "index_book_streams_on_stream_id"

  create_table "books", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "name"
    t.text     "description"
    t.string   "isbn10"
    t.string   "author"
    t.string   "isbn13"
    t.string   "binding"
    t.string   "published"
    t.integer  "pages"
    t.integer  "price"
    t.text     "strengths"
    t.text     "weaknesses"
    t.integer  "category_id"
    t.string   "edition"
    t.integer  "new_book_price"
    t.integer  "old_book_price"
    t.integer  "rank"
    t.integer  "publisher_id"
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "class_adoptions", :force => true do |t|
    t.integer  "rate"
    t.integer  "book_id"
    t.integer  "college_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "class_adoptions", ["book_id"], :name => "index_class_adoptions_on_book_id"
  add_index "class_adoptions", ["college_id"], :name => "index_class_adoptions_on_college_id"

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "offer_position"
    t.integer  "offer_stipend"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "company_users", :force => true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "company_users", ["company_id"], :name => "index_company_users_on_company_id"
  add_index "company_users", ["user_id"], :name => "index_company_users_on_user_id"

  create_table "counters", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "college_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "counters", ["email"], :name => "index_counters_on_email", :unique => true
  add_index "counters", ["reset_password_token"], :name => "index_counters_on_reset_password_token", :unique => true

  create_table "general_images", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "general_id"
  end

  create_table "generals", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "intelligent_book"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  create_table "orders", :force => true do |t|
    t.string   "random"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "user_id"
    t.integer  "total"
    t.integer  "rental_total"
    t.string   "order_type"
    t.boolean  "payment_done",  :default => false
    t.integer  "deposit_total"
  end

  create_table "publishers", :force => true do |t|
    t.integer  "rental"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "requests", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.integer  "user_id"
    t.string   "isbn"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "requests", ["user_id"], :name => "index_requests_on_user_id"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.integer  "book_id"
    t.integer  "user_id"
    t.float    "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "static_pages", :force => true do |t|
    t.string   "page_name"
    t.string   "page_title"
    t.text     "page_content"
    t.boolean  "is_active",    :default => true
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "streams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "provider"
    t.integer  "uid",                    :limit => 8
    t.string   "name"
    t.boolean  "is_admin"
    t.integer  "college_id"
    t.string   "mobile_number"
    t.text     "friends"
    t.integer  "stream_id"
    t.text     "wishlist"
    t.integer  "ambassador_id"
    t.string   "image"
    t.text     "address"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
