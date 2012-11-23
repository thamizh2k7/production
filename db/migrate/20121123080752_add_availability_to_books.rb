class AddAvailabilityToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :availability, :string
  end
end
