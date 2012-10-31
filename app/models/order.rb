class Order < ActiveRecord::Base
  attr_accessible :random, :total, :rental_total

  has_many :book_orders, :dependent => :destroy
  has_many :books, :through => :book_orders

  belongs_to :user
  belongs_to :college

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

  rails_admin do
  	base do
  		field :random do
  			label "Order Number"
  		end
      field :total do
        label "Rental Deposit"
      end
      field :rental_total do
        label "Rental Amount"
      end
  		field :user
  		field :books
  		field :created_at
  		field :updated_at
  	end
  end
end