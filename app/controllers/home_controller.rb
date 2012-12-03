class HomeController < ApplicationController
  def index
    @user=current_user
    if @user
      # check if user has college
      if @user.college.nil?
        redirect_to "/welcome"
        return
      end
      # cart of the user
      cart = @user.cart
      @cart = cart.books
      if session[:cart]
        @cart << Book.find(session[:cart].to_i)
        cart.save
        session[:cart] = nil
      end
      # list of colleges and stream for my account
      @college_names = College.pluck(:name)
      @streams = Stream.pluck(:name)
      # Intelligent Books
      # Using FB friends
      @search = intelligent_books(@user)
      if @search.count == 0
        @search = Book.first(6)
        @load_more = false
      elsif @search.count <= 6
        @load_more = false
      else
        @search = @search.first(6)
        @load_more = true
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
      # check for params of isbn
      if params[:isbn]
        @search = Book.where(:isbn10 => params[:isbn]).first
      end
      @images = General.first.images
  		render "index"
  	end
  end

  def search
    resp = {}
    if params[:query] == ""
      @books = intelligent_books(current_user)
      @books = Book.first(6) if @books.count == 0
    else
  	  @books = Book.search params[:query], :star => true
    end
    @books.delete(nil)
    if @books.count > 6
      resp[:load_more] = true
    else
      resp[:load_more] = false
    end
    @books = @books.first(6)
    resp[:books] = @books.to_json(:include => :publisher)
  	render :json => resp.to_json()
  end

  def load_more
    resp = {}
    load_more_count = params[:load_more_count].to_i * 6
    load_more_limit = load_more_count + 6
    unless params[:query] == ""
      query = "*#{params[:query]}*"
      @books = Book.search(query)
    else
      @books = intelligent_books(current_user)
    end
    @books.delete(nil)
    if @books.count > load_more_limit
      resp[:load_more] = true
    else
      resp[:load_more] = false
    end
    books_to_send = @books[load_more_count, 6]
    resp[:books] = books_to_send.to_json(:include => :publisher)
    render :json => resp
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
    if user
      cart = user.cart
      # add book to the cart
      cart.books << book
      cart.save
      render :json => book.to_json(:include => :publisher)
    else
      session[:cart] = book.id
      render :nothing => true
    end
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

  def update_shipping
    require Rails.root.join('lib','Gharpay.rb')
    user=current_user
    resp = {}
    if user.update_attributes(:address=>params.except(:controller, :action).to_json)
      resp[:text] = "success"
      g=Gharpay::Base.new('gv%tn3fcc62r0YZM','ccxjk24y6y%%%d!#')
      if g.valid_pincode?(params[:address_pincode])
        resp[:gharpay] = "true"
      end
      resp[:user] = user.to_json(:include => {:college => {:only => :name}, :stream => {:only => :name}})
    else
      resp[:text] = "failed"
    end
    render :json => resp
  end

  def get_bank_details
    bank=Bank.find(params[:id])
    render :text=> bank.details
  end

  def book
    @book = Book.find(params[:id])
    @book_image = "http://www.sociorent.in" + ((@book.images.first.nil?) ? "/assets/Sociorent.png" : @book.images.first.image.url).to_s
    render "book", :layout => false
  end

  def validate
    res=false
    case params[:type]
      when "email"
        res="true" if(User.where(:email=>params[:user]["email"]).count==0)
      when "mobile"
        res="true" if(User.where(:mobile_number=>params[:mobile]).count==0)
    end
    render :text=> res and return
  end

  private

  def intelligent_books(user)
    @intelligent_books = []
    if user.friends
      friend_uids = JSON.parse user.friends
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
            @intelligent_books += friend.books if friend.college == user.college
          when "Friends in same College and Stream" 
            @intelligent_books += friend.books if friend.college == user.college && friend.stream == user.stream
        end
      end
    else
      # get users of same college and stream
      similar_users = User.where(:college_id => user.college, :stream_id => user.stream)
      similar_users.each do |similar_user|
        @intelligent_books += similar_user.books
      end
    end
    return @intelligent_books.uniq
  end
  
end