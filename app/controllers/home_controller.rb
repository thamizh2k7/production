class HomeController < ApplicationController
  def index
  	@user = current_user
  	if @user
  		# search books by default will show last 5 books
  		@search = Book.last(5)
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
end