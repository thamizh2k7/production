class AddCodMobileToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :COD_mobile, :string
  end
end
