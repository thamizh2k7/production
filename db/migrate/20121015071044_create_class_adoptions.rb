class CreateClassAdoptions < ActiveRecord::Migration
  def change
    create_table :class_adoptions do |t|
      t.integer :rate
      t.references :book
      t.references :college

      t.timestamps
    end
    add_index :class_adoptions, :book_id
    add_index :class_adoptions, :college_id
  end
end
