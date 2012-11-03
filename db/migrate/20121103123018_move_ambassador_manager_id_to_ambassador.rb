class MoveAmbassadorManagerIdToAmbassador < ActiveRecord::Migration
  def up
  	remove_column :users, :ambassador_manager_id
  	add_column :ambassadors, :ambassador_manager_id, :integer
  end

  def down
  	remove_column :ambassador, :ambassador_manager_id
  	add_column :users, :ambassador_manager_id, :integer
  end
end
