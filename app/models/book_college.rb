class BookCollege < ActiveRecord::Base
  belongs_to :book
  belongs_to :college
  attr_accessible :college_id

  rails_admin do
		base do
			fields :college
		end
		visible false
	end
end