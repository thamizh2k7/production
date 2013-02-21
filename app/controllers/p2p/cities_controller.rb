class P2p::CitiesController < ApplicationController

  layout :p2p_layout

  def index
  end

  def list
    unless params[:query].nil?
  	  cities = P2p::City.select('name').where("name like '" + params[:query] + "%'")
    else
      cities = P2p::City.select('name')
    end

  	if cities.nil? 
  		cities[0] = ['No Result']
  	end

  	render :json => cities.collect{|city| {city.name => city.name}}
  end
end
