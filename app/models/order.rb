class Order < ActiveRecord::Base
  attr_accessible :random, :total, :rental_total, :order_type, :payment_done, :deposit_total,:gharpay_id, :accept_terms_of_use,:citruspay_response,:COD_mobile

  has_many :book_orders, :dependent => :destroy
  has_many :books, :through => :book_orders
  belongs_to :bank

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

  def order_type_enum
    ['cash', 'cheque', 'gharpay']
  end

  rails_admin do
  	base do
  		field :random do
  			label "Order Number"
  		end
      field :deposit_total do
        label "Rental Deposit"
      end
      field :rental_total do
        label "Rental Amount"
      end
      field :accept_terms_of_use
      field :total
  		field :user
  		field :books
      field :order_type
      field :payment_done
      field :bank_id
      field :gharpay_id
      field :book_orders do
        label "Shipped Books of this order"
        pretty_value do
          html = "<table class='table table-hover'><thead><td>Book</td><td>Courier</td><td>Tracking #</td></thead><tbody>"
          value.each do |book_order|
            if book_order.shipped
              html += "<tr><td>#{book_order.book.name}</td>"
              html += "<td>#{book_order.courier_name}</td>"
              html += "<td>#{book_order.tracking_number}</td></tr>"
            end
          end
          html += "</tbody></table>"
          html.html_safe
        end
      end
  		field :created_at
  		field :updated_at
  	end
  end
end