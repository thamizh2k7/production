class HomeController < ApplicationController
  def index
  	@user = current_user
  	if @user
      # check if user has college
      if @user.college.nil?
        redirect_to "/welcome"
        return
      end
  		# search books by default will show last 5 books
  		@search = Book.last(5)
      # cart of the user
      cart = @user.cart
      @cart = cart.books
      # list of colleges and stream for my account
      @college_names = College.pluck(:name)
      @streams = Stream.pluck(:name)
      # Intelligent Books
      # Using FB friends
      @intelligent_books = []
      if @user.friends
        friend_uids = JSON.parse @user.friends
        all_uids = JSON.parse User.select("uid").to_json()
        friends_who_use_sociorent_uids = all_uids & friend_uids
        # get all books their friends ordered
        friends_who_use_sociorent_uids.each do |uid|
          friend = User.where(:uid => uid["uid"]).first
          # check condition on friend from the General Setting
          general = General.first
          case general.intelligent_book
            when "All friends"
              @intelligent_books += friend.books
            when "Friends in same College"    
              @intelligent_books += friend.books if friend.college == @user.college
            when "Friends in same College and Stream" 
              @intelligent_books += friend.books if friend.college == @user.college && friend.stream == @user.stream
          end
        end
        @intelligent_books.uniq
        if @intelligent_books.count == 0
          @intelligent_books = Book.offset(rand(Book.count)).first(10)
        end
      else
        # get users of same college and stream
        similar_users = User.where(:college_id => @user.college, :stream_id => @user.stream)
        similar_users.each do |similar_user|
          @intelligent_books += similar_user.books
        end
        if @intelligent_books.count == 0
          @intelligent_books = Book.offset(rand(Book.count)).first(10)
        end
      end
      # orders made by the user
      @orders = @user.orders
      # companies for internship
      @companies = Company.all
  		# render inner when user is logged in
  		render "inner"
    elsif @counter = current_counter
      render "counter"
  	else
      @images = General.first.general_images.all
  		render "index"
  	end
  end

  def search
  	query = "*#{params[:query]}*"
  	@books = Book.search query
  	render :json => @books.to_json(:include => :publisher)
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
    render :json => book.to_json(:include => :publisher)
  end

  def remove_from_cart
    # getting common variables
    book = Book.find(params[:book].to_i)
    user = current_user
    cart = user.cart
    # remove book from cart
    book_cart = cart.book_carts.where(:book_id => book).first
    book_cart.delete
    render :json => book.to_json(:include => :publisher)
  end

  def get_adoption_rate
    user = current_user
    @book = Book.find(params[:book].to_i)
    resp = []
    class_adoption_resp = []
    review_resp = []
    College.all.each do |college|
      class_adoption = @book.class_adoptions.where(:college_id => college).first.to_json(:only => [:rate,:id], :include =>{:college => {:only => [:name]}})
      unless class_adoption == "null"
        class_adoption_resp << JSON.parse(class_adoption)
      else
        class_adoption = Hash.new
        class_adoption["rate"] = @book.orders.where(:user_id => college.users).count
        college_name = Hash.new
        college_name["name"] = college.name
        class_adoption["college"] = college_name
        class_adoption_resp << class_adoption
      end
    end
    review_resp = JSON.parse @book.reviews.to_json(:include => {:user => {:only => :name}})
    # check if current user is allowed to make a review for this book
    if user.books.where(:id => @book).first.nil? || user.reviews.where(:book_id => @book).first
      review_resp << {"make_review"=>0}
    else
      review_resp << {"make_review"=>1}
    end
    resp << review_resp
    resp << class_adoption_resp
    render :json => resp.to_json()
  end

  def make_review
    user = current_user
    book = Book.find(params[:book].to_i)
    review = user.reviews.create(:content => params[:content], :book_id => book.id)
    render :json => review.to_json(:include => {:user => {:only => :name}})
  end

  def apply_intership
    user = current_user
    company = Company.find(params[:company_id].to_i)
    company.company_users.create(:user_id => user.id)
    render :nothing => true
  end
end