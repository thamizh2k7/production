class Resource < ActiveRecord::Base
  attr_accessible :link, :name, :image_attributes

  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image, :allow_destroy => true

  rails_admin do
  	base do
  		fields :name
  		fields :link
  		fields :image do
  			pretty_value do
  				html = ""
  				unless value.nil?
						html += "<a href=" + value.image(:original).to_s + "class='thumbnail' target='blank'><img src=" + value.image(:thumb).to_s + "></a><br/><br/>"
          end
					html.html_safe				
  			end
  		end
  	end
  end

end