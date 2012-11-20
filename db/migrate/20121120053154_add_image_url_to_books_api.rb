class AddImageUrlToBooksApi < ActiveRecord::Migration
  def change
  	add_column :book_apis, :image_url, :text
  end
end
