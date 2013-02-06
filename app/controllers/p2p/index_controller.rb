class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    # @mobiles=P2p::Item.select("title,price").where('product_id=1').limit(4);
    # @electronics=P2p::Item.select("title,price").where('product_id=2').limit(4);
     
    @list = P2p::Category.limit(8).order("priority")

  end

  def search

    puts "called search"    
    @result = ThinkingSphinx.search "*#{params[:id]}*" ,:classes => [P2p::Item,P2p::Product,P2p::Category] 
    #@products.to_json
    puts "--------res" 
    puts @result
    
     @search_result=[]
     @items_from_category={}
     @items_from_product=[]
     @items_from_search=[]

    @result.each do |res| 
      
      puts "#{res} -> #{res.class.to_s}"
      
       if res.class.to_s == "P2p::Category"
        result_items = {}
        temp=[]
        puts"category-name: #{res.name}"
        res.products.each do |prod|
          result_items = prod.items.select("title,price").limit(10)
          #@search_result += result_items
          temp+= result_items
          
        end
          @items_from_category=["#{res.name}"=>temp]
          puts "------->#{result_items}"
       elsif res.class.to_s == "P2p::Product"
        res1=P2p::Item.select("title,price").find(res.category_id)
        if res1.nil?
          @items_from_product+=res1
        end
        #@search_result << res1

       else

        @items_from_search << res
        # @search_result << res
       end

       @search_result={:category=>@items_from_category,:prducts=>@items_from_product,:items=>@items_from_search }


  end


    render :text => @search_result.to_json
  end 

end
