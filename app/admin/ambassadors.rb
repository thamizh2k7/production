ActiveAdmin.register Ambassador do
  index do
  	column "Ambassador", :sortable=>:true,  :ambassador do |amb|
  		amb.ambassador_manager.name
  	end
  	column "College", :amb_college do |amb|
  		Ambassador.find(amb).college.name
  	end
  end
  
end
