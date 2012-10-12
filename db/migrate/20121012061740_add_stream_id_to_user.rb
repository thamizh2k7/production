class AddStreamIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :stream_id, :integer
  end
end
