class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    @mobiles=P2p::Item.select("title,price").where('category_id=1').limit(4);
    @electronics=P2p::Item.select("title,price").where('category_id=2').limit(4);
     

  end

  def search
    puts "called search"    
    @category =P2p::Category.search "#{params[:id]}" 
    #@products.to_json
    puts "--------res" 
    puts @category
    
    @category.each do |c| 
      puts c.id
      # c.items.each do |item|
      #   puts item.title,item.price
      # end
 


    end
    render :text => @category.to_json
  end 

end
