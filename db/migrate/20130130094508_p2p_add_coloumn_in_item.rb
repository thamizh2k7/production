class P2pAddColoumnInItem < ActiveRecord::Migration
  def change
     add_column :p2p_items, :price, :float
  end
end
