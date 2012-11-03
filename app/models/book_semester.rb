class BookSemester < ActiveRecord::Base
  belongs_to :book
  belongs_to :semester
  attr_accessible :semester_id

  rails_admin do
		base do
			fields :semester
		end
		visible false
	end
end
