class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    @mobiles=P2p::Item.select("title,price").where('product_id=1').limit(4);
    @electronics=P2p::Item.select("title,price").where('product_id=2').limit(4);
     

  end

  def search
    puts "called search"    
    @category = P2p::Category.search "#{params[:id]}" 
    #@products.to_json
    puts "--------res" 
    puts @category
    @search_result=[]
    @category.each do |c| 

      puts c
      #items=P2p::Item.select("title,price").where('category_id=c.id')
      items=c.items.select("title,price")
      @search_result += items
      # c.items.each do |item|
      #   puts item.title,item.price
      # end
 


    end
    render :text => @search_result.to_json
  end 

end
