class Order < ActiveRecord::Base
  attr_accessible :random

  has_many :book_orders
  has_many :books, :through => :book_orders

  belongs_to :user

  after_create do |order|
  	unique = 0
  	until unique == 1
	  	r = Random.new
	  	random = r.rand(10000..999999)
	  	order_search_with_random = Order.where(:random => random).first
	  	if order_search_with_random.nil?
	  		unique = 1
	  		order.update_attributes(:random => random)
	  	end
	  end
  end
end