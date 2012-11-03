class RemoveNameFromAmbassador < ActiveRecord::Migration
  def up
    remove_column :ambassadors, :name
  end

  def down
    add_column :ambassadors, :name, :string
  end
end
