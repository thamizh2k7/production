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
end