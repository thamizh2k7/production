class BookCart < ActiveRecord::Base
  attr_accessible :book_id, :cart_id

  belongs_to :book
  belongs_to :cart
end
