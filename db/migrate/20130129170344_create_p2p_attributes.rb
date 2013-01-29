class CreateP2pAttributes < ActiveRecord::Migration
  def change
    create_table :p2p_attributes do |t|
      t.string :name
      t.integer :display_type, :default => 1
      t.integer :parent_id
      t.references :category_id

      t.timestamps
    end

    add_index :p2p_attributes, :category_id
  end
end
