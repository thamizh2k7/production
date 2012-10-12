class AddIntelligentBookToGeneral < ActiveRecord::Migration
  def change
    add_column :generals, :intelligent_book, :string
  end
end
