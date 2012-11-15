class AddDepositTotalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :deposit_total, :integer
  end
end
