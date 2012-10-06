class CreateGeneralImages < ActiveRecord::Migration
  def change
    create_table :general_images do |t|

      t.timestamps
    end
  end
end
