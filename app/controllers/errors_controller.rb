class ErrorsController < ApplicationController

  def routing
   	flash[:warning] = "Page not found"
  end

  def ignore_routing
  	render "errors/errors"
  end

  def index
  	render "errors/errors"
  end

end