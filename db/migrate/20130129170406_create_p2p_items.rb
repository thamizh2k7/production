class CreateP2pItems < ActiveRecord::Migration
  def change
    create_table :p2p_items do |t|
      t.references :category
      t.references :user
      t.string :title 
      t.text :desc
      t.integer :paytype 
      t.datetime :solddate
      t.datetime :paiddate
      t.datetime :delivereddate
      t.boolean :approvedflag, :default => false
      t.integer :viewcount ,:default => 0
      t.integer :reqCount,:default => 0

      t.timestamps
    end
    add_index :p2p_items, :category_id
    add_index :p2p_items, :user_id

  end
end
