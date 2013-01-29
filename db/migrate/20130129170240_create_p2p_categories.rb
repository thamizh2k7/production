class CreateP2pCategories < ActiveRecord::Migration
  def change
    create_table :p2p_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
