class StaticPage < ActiveRecord::Base
  attr_accessible :page_name, :page_title, :page_content, :is_active
  rails_admin do 
  	list
  	show
  	create do
  		include_all_fields
  		field :page_name do
  			read_only false
  		end 
  	end


  	edit do
  		include_all_fields
  		field :page_name do
  			read_only true
  		end 
  	end  	
  end
end
