class AddAmbassadorIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :ambassador_id, :integer
  end
end
