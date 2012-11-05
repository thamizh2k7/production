class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :offer_position
      t.integer :offer_stipend

      t.timestamps
    end
  end
end
