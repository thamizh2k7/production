class AddRentalTotalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :rental_total, :integer
  end
end
