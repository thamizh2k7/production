class AddWishlistToUser < ActiveRecord::Migration
  def change
    add_column :users, :wishlist, :text
  end
end
