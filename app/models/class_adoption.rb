class ClassAdoption < ActiveRecord::Base
  belongs_to :book
  belongs_to :college
  
  attr_accessible :rate, :book_id, :college_id

  rails_admin do
		base do
			fields :rate
			fields :college
		end
		visible false
	end
end