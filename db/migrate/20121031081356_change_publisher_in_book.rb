class ChangePublisherInBook < ActiveRecord::Migration
  def up
  	remove_column :books, :publisher
  	add_column :books, :publisher_id, :integer
  end

  def down
  	add_column :books, :publisher, :string
  	remove_column :books, :publisher_id
  end
end
