class CreateGenerals < ActiveRecord::Migration
  def change
    create_table :generals do |t|

      t.timestamps
    end
  end
end
