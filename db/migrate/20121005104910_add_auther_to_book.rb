class AddAutherToBook < ActiveRecord::Migration
  def change
    add_column :books, :auther, :string
    rename_column :books, :isbn, :isbn10
    add_column :books, :isbn13, :string
    add_column :books, :binding, :string
    add_column :books, :publisher, :string
    add_column :books, :published, :date
    add_column :books, :pages, :integer
    add_column :books, :price, :integer
    add_column :books, :age, :string
    add_column :books, :strengths, :text
    add_column :books, :weaknesses, :text
  end
end
