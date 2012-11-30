class AddGharpayIDtoOrders < ActiveRecord::Migration
  def change
  	add_column :orders,  :gharpay_id,:string
  end
end
