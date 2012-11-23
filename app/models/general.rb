class General < ActiveRecord::Base
  attr_accessible :general_images_attributes, :intelligent_book, :welcome_mail_subject, :welcome_mail_content

  has_many :general_images

  def intelligent_book_enum
    ['All friends', 'Friends in same College', 'Friends in same College and Stream']
  end

  accepts_nested_attributes_for :general_images, :allow_destroy => true

  rails_admin do
  	
  	base do
      field :intelligent_book do
        label "Intelligent Books Filter Algorithm"
      end
  		field :general_images do
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
      field :welcome_mail_subject
      field :welcome_mail_content
  	end

  end
end