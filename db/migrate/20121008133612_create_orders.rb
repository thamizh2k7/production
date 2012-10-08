class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :random

      t.timestamps
    end
  end
end
