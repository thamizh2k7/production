class Shipping < ActiveRecord::Base
  belongs_to :book_orders
end
