class OrdersController < ApplicationController
	def create
		user = current_user
		cart = user.cart
		books = cart.books
		# total price - save this in orders
		total = cart.books.sum(:price)
		# creating an order
		order = user.orders.create(:total => total)
		# adding all the books in the cart to order
		order.books = cart.books
		order.save
		# empty the cart
		cart.book_carts.each do |book_cart|
			book_cart.delete
		end

		render :json => order.to_json()
	end

	def rented_show_more
		@rented_books = []
		offset = params[:offset].to_i
		count = 1
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
end