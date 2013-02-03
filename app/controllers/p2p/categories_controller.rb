class P2p::CategoriesController < ApplicationController

 before_filter :p2p_layout 

   def index
  	list
  end
  
end
