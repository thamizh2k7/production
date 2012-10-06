class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :author
      t.references :user
      t.string :isbn

      t.timestamps
    end
    add_index :requests, :user_id
  end
end
