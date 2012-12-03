class ChangeLimitOfStaticPageContent < ActiveRecord::Migration
  def up
  	remove_column :static_pages, :page_content
  	add_column :static_pages, :page_content, :text, :limit => 4294967295
  end

  def down
  	remove_column :static_pages, :page_content
  	add_column :static_pages, :page_content, :text, :limit => 4294967295
  end
end
