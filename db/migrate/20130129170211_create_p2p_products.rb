class CreateP2pProducts < ActiveRecord::Migration
  def change
    create_table :p2p_products do |t|
      t.string :name

      t.timestamps
    end
  end
end
