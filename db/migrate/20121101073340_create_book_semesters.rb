class CreateBookSemesters < ActiveRecord::Migration
  def change
    create_table :book_semesters do |t|
      t.references :book
      t.references :semester

      t.timestamps
    end
    add_index :book_semesters, :book_id
    add_index :book_semesters, :semester_id
  end
end
