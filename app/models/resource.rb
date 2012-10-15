class Resource < ActiveRecord::Base
  attr_accessible :link, :name, :images_attributes

  has_many :images, :as => :imageable

  accepts_nested_attributes_for :images, :allow_destroy => true

  rails_admin do
  	base do
  		fields :name
  		fields :link
  		fields :images do
  			pretty_value do
  				html = ""
  				unless value.first.nil?
						value.each do |image|
							html += "<a href=" + image.image(:original).to_s + "class='thumbnail' target='blank'><img src=" + image.image(:thumb).to_s + "></a><br/><br/>"
						end
          end
					html.html_safe				
  			end
  		end
  	end
  end

end