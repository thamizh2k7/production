class ChangeColumnNameAuther < ActiveRecord::Migration
  def up
  	rename_column :books, :auther, :author
  end

  def down
  	rename_column :books, :author, :auther
  end
end
