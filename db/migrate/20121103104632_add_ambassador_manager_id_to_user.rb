class AddAmbassadorManagerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :ambassador_manager_id, :integer
  end
end
