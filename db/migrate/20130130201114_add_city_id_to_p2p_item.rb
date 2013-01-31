class AddCityIdToP2pItem < ActiveRecord::Migration
  def change
    add_column :p2p_items, :city_id , :integer
    add_index :p2p_items, :city_id
  end
end
