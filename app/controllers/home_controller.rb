class HomeController < ApplicationController
  def index
  	@user = current_user
  	if @user
  		render "inner"
  	else
  		render "index"
  	end
  end
end