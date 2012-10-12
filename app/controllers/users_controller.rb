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
end