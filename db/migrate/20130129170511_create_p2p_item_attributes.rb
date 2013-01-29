class CreateP2pItemAttributes < ActiveRecord::Migration
  def change
    create_table :p2p_item_attributes do |t|
      t.references :attribute
      t.string :value
      t.references :item

      t.timestamps
    end
    add_index :p2p_item_attributes, :attribute_id
    add_index :p2p_item_attributes, :item_id
  end
end
