class HomeController < ApplicationController
  def index
  	@user = current_user
  	if @user
  		# search books by default will show last 5 books
  		@search = Book.last(5)
  		# render inner when user is logged in
  		render "inner"
  	else
  		render "index"
  	end
  end

  def search
  	query = "*#{params[:query]}*"
  	@books = Book.search query
  	render :json => @books.to_json()
  end
end