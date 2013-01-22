ActiveAdmin.register Ambassador do
  index do

    selectable_column
  	column "Ambassador", :ambassador do |amb|
  		amb.ambassador_manager.name
  	end
    column :colleges do |amb|
      html=""
      amb.colleges.each do |col|
        html+="#{col.name}"
        html+="<br>"
      end
      raw html
    end
  	default_actions
  end
  form do |f|
    f.inputs "Ambassador" do
      f.input :ambassador_manager
      f.inputs "Colleges" do 
        f.input :colleges , :collection => College.all
      end
      f.buttons
    end
  end
  show do |ambassador|
    attributes_table do
      row :ambassador_manager
      row :colleges do |amb|
        html=""
        amb.colleges.each do |col|
          html+= "#{col.name}<br>"
        end
        raw html
      end
    end
  end
end
