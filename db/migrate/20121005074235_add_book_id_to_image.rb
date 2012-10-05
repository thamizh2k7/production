class AddBookIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :book_id, :integer
  end
end
