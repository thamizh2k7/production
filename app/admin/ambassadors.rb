ActiveAdmin.register Ambassador do
  index do

    selectable_column
  	column "Ambassador", :ambassador do |amb|
  		amb.ambassador_manager.name
  	end
  	column :college

  	default_actions
  end
end
