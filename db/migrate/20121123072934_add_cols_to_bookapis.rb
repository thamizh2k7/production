class AddColsToBookapis < ActiveRecord::Migration
  def change
  	change_table :book_apis do |t|
  		t.string :availability
  		t.decimal :price, :precision => 10, :scale => 2
  		t.text :description
  	end
  end
end
