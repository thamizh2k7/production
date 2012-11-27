class AddCollegeAndStreamsToBookApis < ActiveRecord::Migration
  def change
  	add_column :book_apis, :college, :string
  	add_column :book_apis, :stream, :string
  end
end
