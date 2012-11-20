class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
    	t.string :page_name
    	t.string :page_title
    	t.text :page_content
    	t.boolean :is_active, :default=>true
      t.timestamps
    end
  end
end
