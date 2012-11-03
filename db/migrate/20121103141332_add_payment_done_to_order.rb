class AddPaymentDoneToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_done, :boolean, :default => false
  end
end
