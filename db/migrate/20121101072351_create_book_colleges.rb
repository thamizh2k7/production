class CreateBookColleges < ActiveRecord::Migration
  def change
    create_table :book_colleges do |t|
      t.references :book
      t.references :college

      t.timestamps
    end
    add_index :book_colleges, :book_id
    add_index :book_colleges, :college_id
  end
end
