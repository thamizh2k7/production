class CreateBookApis < ActiveRecord::Migration
  def change
    create_table :book_apis do |t|
    	t.string :book
			t.string :author
			t.string :isbn
			t.string :isbn13
			t.string :binding
			t.string :publishing_date
			t.string :publisher
			t.string :edition
			t.integer :number_of_pages
			t.string :language
      t.timestamps
    end
  end
end
