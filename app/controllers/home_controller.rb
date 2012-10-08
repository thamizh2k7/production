class HomeController < ApplicationController
  def index
  	@user = current_user
  	if @user
  		# search books by default will show last 5 books
  		@search = Book.last(5)
      # cart of the user
      cart = @user.cart
      @cart = cart.books
  		# render inner when user is logged in
  		render "inner"
  	else
      @images = General.first.general_images.all
  		render "index"
  	end
  end

  def search
  	query = "*#{params[:query]}*"
  	@books = Book.search query
  	render :json => @books.to_json()
  end

  def book_request
    user = current_user
    user.requests.create(:title => params[:title], :author => params[:author], :isbn => params[:isbn])
    render :text => "Your request was submitted, Thank you."
  end

  def add_to_cart
    # getting common variables
    book = Book.find(params[:book].to_i)
    user = current_user
    cart = user.cart
    # add book to the cart
    cart.books << book
    cart.save
    render :json => book.to_json()
  end

  def remove_from_cart
    # getting common variables
    book = Book.find(params[:book].to_i)
    user = current_user
    cart = user.cart
    # remove book from cart
    book_cart = cart.book_carts.where(:book_id => book).first
    book_cart.delete
    render :json => book.to_json()
  end
end