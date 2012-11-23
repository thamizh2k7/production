 class OrdersController < ApplicationController
	def create
		user = current_user
		cart = user.cart
		books = cart.books
		# total price - save this in orders
		deposit_total = cart.books.sum(:price)
		rental_total = 0
		cart.books.each do |book|
			rental_total += (book.price * book.publisher.rental)/100
		end
		shipping_charge = deposit_total < 1000 ? 50 : 0
		total = deposit_total + shipping_charge
		order_type = params[:order_type]
		# creating an order
		order = user.orders.create(:total => total, :rental_total => rental_total, :deposit_total => deposit_total, :order_type => order_type)
		# adding all the books in the cart to orders
		order.books = cart.books
		order.save

		#send the sms when the user completes the order
    sms_text=Sms.where(:sms_type=>"order").first.content
    send_sms(user.mobile_number,"Thank you..#{sms_text}")
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
end