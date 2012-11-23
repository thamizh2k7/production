class AddShippedToBookOrder < ActiveRecord::Migration
  def change
    add_column :book_orders, :shipped, :boolean, :default => false
    add_column :book_orders, :courier_name, :string
    add_column :book_orders, :tracking_number, :string
  end
end
