class Image < ActiveRecord::Base
	attr_accessible :image
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :book => "130x160>" }

  belongs_to :book

  rails_admin do
		base do
			fields :image
		end
		visible false
	end
end
