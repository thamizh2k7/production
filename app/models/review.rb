class Review < ActiveRecord::Base
  attr_accessible :rating, :content, :book_id, :user_id

  belongs_to :book
  belongs_to :user

  rails_admin do
		base do
			fields :user
			fields :rating
			fields :content
		end
		visible false
	end
end
