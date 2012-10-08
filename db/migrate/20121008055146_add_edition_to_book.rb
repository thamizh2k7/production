class AddEditionToBook < ActiveRecord::Migration
  def change
    add_column :books, :edition, :string
    add_column :books, :new_book_price, :integer
    add_column :books, :old_book_price, :integer
  end
end
