class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :name
      t.references :college

      t.timestamps
    end
    add_index :ambassadors, :college_id
  end
end
