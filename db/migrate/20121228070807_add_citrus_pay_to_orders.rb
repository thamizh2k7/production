class AddCitrusPayToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :citruspay_response, :string
  end
end
