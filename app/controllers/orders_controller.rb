require 'koala'
class OrdersController < ApplicationController
	def create
		user = current_user
		cart = user.cart
		books = cart.books
		# total price - save this in orders
		deposit_total = cart.books.sum(:price)
		rental_total = 0
		cart_items=[]
		cart.books.each do |book|
			rental_price = (book.price.to_i * book.publisher.rental.to_i)/100
			rental_total += rental_price
			product={"productID" =>book.isbn13,"unitCost"=>rental_price,"productDescription"=>book.name}
			cart_items << product
		end
		shipping_charge = deposit_total < 1000 ? 50 : 0
		total = deposit_total + shipping_charge
		order_type = params[:order_type]
		accept_terms_of_use = params[:accept_terms_of_use]
		# creating an order
		order = user.orders.create(:total => total, :rental_total => rental_total, :deposit_total => deposit_total, :order_type => order_type, :accept_terms_of_use => accept_terms_of_use)
		if order_type=="gharpay"
			order_array={}
			user_address=JSON.parse(user.address)
			address=user_address.map{|k,v| "#{v}"}.join(',')
			dd=Time.now + (24*60*60*3)
			delivery=dd.strftime("%d-%m-%Y")
    	order_array["customerDetails"]={"firstName"=>user.name,"contactNo"=>user.mobile_number,"address"=>address}
    	order_array["orderDetails"]={"deliveryDate"=>delivery,"pincode"=>user_address["address_pincode"],"orderAmount"=>total,"clientOrderID"=>order.random}
    	order_array["productDetails"]=cart_items
	    g=Gharpay::Base.new('gv%tn3fcc62r0YZM','ccxjk24y6y%%%d!#')
	    gharpay_resp = g.create_order(order_array)
	    if gharpay_resp["status"]==true
	    	order.update_attributes(:gharpay_id=>gharpay_resp["orderID"])
	    end
		end
		unless params[:bank_id].nil?
    	bank=Bank.where(:id=>params[:bank_id]).first
    	if bank
    		#adding the bank to order
    		order.bank = bank
    		#sending the sms
    		uniqueid =" Unique ID:#{user.unique_id}"
    		bank_details = " The Bank Account Details:#{strip_html(bank.details)}"
    		sms_text = "Sociorent.com #{uniqueid} #{bank_details}"
    		send_sms(user.mobile_number,sms_text)
    	end
    end

    if ENV["RAILS_ENV"] == "production"
	    # koala publish actions 
	    unless user.token.nil?
	    	token = user.token
	    	graph  = Koala::Facebook::API.new(token)
	    	books.each do |book|
		    	book_url = "http://www.sociorent.in/book/details/#{book.id}"
		    	graph.put_connections("me", "sociorent:rented", :book => book_url)
		    end
	    end
	  end

    # adding all the books in the cart to orders
		order.books = cart.books
		order.save

		# mail 
		UserMailer.order_email(user, order).deliver

		#send the sms when the user completes the order
    sms_text=Sms.where(:sms_type=>"order").first.content
    send_sms(user.mobile_number,"#{sms_text}")
    
		# empty the cart
		cart.book_carts.each do |book_cart|
			book_cart.delete
		end

		render :json => order.to_json(:include => {:books => {:only => [:name, :price, :author, :id]}})
	end

	def rented_show_more
		@rented_books = []
		count = 10
		offset = params[:offset].to_i * count
		select = params[:select]
    if select == "all"
    	@orders = Order.includes(:books).all
    else
    	college = College.where(:name => select).first
    	@orders = college.orders
    end	  
    @orders.each do |order|
	    if @rented_books.count <= offset
	      @rented_books += order.books
	    else
	      break
	    end
	  end
	  @rented_books = @rented_books.drop(offset-count).first(count)
	  render :json => @rented_books.to_json()
	end

	def rented_college
    @rented_books = []
    @number_of_books = 0
    count = 1
    select = params[:select]
    resp = {}
    if select == "all"
    	@orders = Order.includes(:books).all
    else
    	college = College.where(:name => select).first
    	@orders = college.orders
    end
    @orders.each do |order|
      if @rented_books.count <= count
        @rented_books += order.books
        @number_of_books += order.books.count
      else
        @number_of_books += order.books.count
      end
    end
    resp[:books] = @rented_books = @rented_books.first(count)
    resp[:number_of_books] = @number_of_books
    render :json => resp.to_json()
	end

	def counter_cash_payment
		msg = {}
		counter = current_counter
		order = Order.find(params[:order_id].to_i)
		if order.order_type == "cash" && order.user.college == counter.college
			order.update_attributes(:payment_done => true)
			msg[:status] = 1
			msg[:msg] = "Order payment confirmed."
		else
			msg[:status] = 0
			msg[:msg] = "Invalid order."
		end
		render :json => msg
	end

	private
	def strip_html(html_page)
  	html_page.to_s.gsub!(/(<[^>]+>|&nbsp;|\r|\n)/,"")
	end
end