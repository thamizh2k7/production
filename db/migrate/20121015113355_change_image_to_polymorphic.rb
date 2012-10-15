class ChangeImageToPolymorphic < ActiveRecord::Migration
  def up
  	rename_column :images, :book_id, :imageable_id
  	add_column :images, :imageable_type, :string
  end

  def down
  	rename_column :images, :imageable_id, :book_id
  	remove_column :images, :imageable_type
  end
end
