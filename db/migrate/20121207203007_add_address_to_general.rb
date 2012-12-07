class AddAddressToGeneral < ActiveRecord::Migration
  def change
    add_column :generals, :address, :text
  end
end
