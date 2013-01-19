class BookOrder < ActiveRecord::Base
  attr_accessible :shipped, :tracking_number, :courier_name, :shipped_date
  belongs_to :book
  belongs_to :order
end
