class OrdersController < ApplicationController
	def create
		user = current_user
		cart = user.cart
		books = cart.books
		# creating an order
		order = user.orders.create()
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
	  @orders = Order.includes(:books).all
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
end