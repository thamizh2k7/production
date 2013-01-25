class ErrorsController < ApplicationController

  def routing
   
  end

  def ignore_routing
  	render "errors/errors"
  end

  def index
  	render "errors/errors"
  end

end