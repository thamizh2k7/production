class UsersController < ApplicationController
  def get_user_details
    user = current_user
    if user.mobile_number.nil?
      @college_names = College.pluck(:name)
      @streams = Stream.pluck(:name)
      render "home/get_user_details"
    else
      redirect_to "/"
    end
  end

  def save_user_details
    user = current_user
    college = College.where(:name => params[:college]).first
    stream = Stream.where(:name => params[:stream]).first
    user.update_attributes(:mobile_number => params[:mobile], :college_id => college.id, :stream_id => stream.id)
    render :text => "1"
  end

  def update
  	user = current_user
    college = College.where(:name => params[:college]).first
    stream = Stream.where(:name => params[:stream]).first
  	user.update_attributes(:name => params[:name], :mobile_number => params[:mobile_number], :college_id => college.id, :stream_id => stream.id)
  	render :nothing => true
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
    resp = []
    unless user.wishlist.nil?
      wishlist = JSON.parse user.wishlist
      wishlist.uniq
      wishlist.each do |id|
        resp << Book.find(id.to_i)
      end
    end
    render :json => resp.to_json()
  end

  def remove_from_wishlist
    user = current_user
    wishlist = JSON.parse user.wishlist
    book = Book.find(params[:book].to_i)
    wishlist.delete book.id
    user.update_attributes(:wishlist => wishlist.to_json())
    render :nothing => true
  end

  def select_reference
    ambassador = Ambassador.find(params[:ambassador_id].to_i)
    user = current_user
    user.ambassador = ambassador
    user.save
    render :nothing => true
  end
end