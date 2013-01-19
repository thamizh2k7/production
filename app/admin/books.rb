ActiveAdmin.register Book do
	collection_action :rented_books do
		@number_of_books = 0
	  count = 10
	  @colleges = College.pluck(:name)
	  @rented_books = []
	  @orders = Order.includes(:books).all
	  @orders.each do |order|
		  if @rented_books.count <= count
	      @rented_books += order.books
	      @number_of_books += order.books.count
	    else
	       @number_of_books += order.books.count
	    end
	  end
    @rented_books = @rented_books.first(count)
	end
	action_item :only => [:index] do
    link_to('Rented Books',rented_books_admin_books_path())
  end
end
