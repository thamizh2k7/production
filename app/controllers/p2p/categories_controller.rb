class P2p::CategoriesController < ApplicationController

 layout :p2p_layout 

  def index
  	@res = []
  	P2p::Category.all.each do |c|
  		@res << {:value => c.id, :text => c.name}
  	end
  	render :json => @res
  end
  
end
