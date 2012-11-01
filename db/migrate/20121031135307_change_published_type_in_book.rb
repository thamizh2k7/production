class ChangePublishedTypeInBook < ActiveRecord::Migration
  def up
  	change_column :books, :published, :string
  	remove_column :books, :age
  end

  def down
  	change_column :books, :published, :date
  	add_column :books, :age, :string
  end
end
