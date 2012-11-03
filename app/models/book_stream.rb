class BookStream < ActiveRecord::Base
  belongs_to :book
  belongs_to :stream
  attr_accessible :stream_id

  rails_admin do
		base do
			fields :stream
		end
		visible false
	end
end
