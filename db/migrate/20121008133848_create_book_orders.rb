class CreateBookOrders < ActiveRecord::Migration
  def change
    create_table :book_orders do |t|
      t.references :book
      t.references :order

      t.timestamps
    end
    add_index :book_orders, :book_id
    add_index :book_orders, :order_id
  end
end
