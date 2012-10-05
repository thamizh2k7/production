class AddNameToBook < ActiveRecord::Migration
  def change
    add_column :books, :name, :string
    add_column :books, :description, :text
    add_column :books, :isbn, :string
  end
end
