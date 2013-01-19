ActiveAdmin.register Book do
	index do
		selectable_column
		column :name
		column :isbn13
		column :price
		count = 0
  	column :description do |d|
  		count+=1
  		d.description.gsub! /'/, '|'
  		raw "<a class='view_description button' show-desc='#{count}'>View Description</a> <input id='#{count}' type='hidden' value='#{d.description}'/>"
  	end
  	render :partial => "admin/book/index"
  	default_actions
  end
end
