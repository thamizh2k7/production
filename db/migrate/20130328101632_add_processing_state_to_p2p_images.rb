class AddProcessingStateToP2pImages < ActiveRecord::Migration
  def change
    add_column :p2p_images, :process_status, :integer ,:default => 0
  end
end
