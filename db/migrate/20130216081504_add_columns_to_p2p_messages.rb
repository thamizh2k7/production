class AddColumnsToP2pMessages < ActiveRecord::Migration

  def change
  	remove_column :p2p_messages , :flag
  	remove_column :p2p_messages , :sender
  	remove_column :p2p_messages , :receiver

  	add_column :p2p_messages , :sender_id ,:integer
  	add_column :p2p_messages , :receiver_id ,:integer
	add_column :p2p_messages , :parent_id ,:integer

  	add_index :p2p_messages , :sender_id
  	add_index :p2p_messages , :receiver_id
	add_index :p2p_messages , :parent_id

  end

end
