class UsersController < ApplicationController
  def get_user_details
    user = current_user
    if user.mobile_number.nil?
      @college_names = College.pluck(:name)
      @streams = Stream.pluck(:name)
    else
      redirect_to "/"
    end
  end

  def save_user_details
    user = current_user
    college = College.where(:name => params[:college]).first
    puts params[:stream]
    stream = Stream.where(:name => params[:stream]).first
    user.update_attributes(:mobile_number => params[:mobile], :college_id => college.id, :stream_id => stream.id)
    render :text => "1"
  end

  def update
  	user = current_user
  	user.update_attributes(:name => params[:name], :mobile_number => params[:mobile_number])
  	render :nothing => true
  end

  def orders
    user = current_user
    orders = user.orders
    render :json => orders.to_json(:include => {:books => {:only => [:name, :price, :author]}})
  end

  def add_to_wishlist
    user = current_user
    book = Book.find(params[:book].to_i)
    if user.wishlist.nil?
      wishlist = []
    else
      wishlist = JSON.parse user.wishlist
    end
    wishlist << book.id
    user.update_attributes(:wishlist => wishlist.to_json())
    render :json => wishlist.to_json()
  end

  def wishlist
    user = current_user
    wishlist = JSON.parse user.wishlist
    wishlist.uniq
    resp = []
    wishlist.each do |id|
      resp << Book.find(id.to_i)
    end
    render :json => resp.to_json()
  end
end