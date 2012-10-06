class AddGeneralIdToGeneralImage < ActiveRecord::Migration
  def change
    add_column :general_images, :general_id, :integer
  end
end
