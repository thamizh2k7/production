class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    # @mobiles=P2p::Item.select("title,price").where('product_id=1').limit(4);
    # @electronics=P2p::Item.select("title,price").where('product_id=2').limit(4);
     
    @list = P2p::Category.limit(2).order("priority")

  end

  def search

    

      # unless request.respond_to?("xhr")

      #     all_spec = {}

      #     result = ThinkingSphinx.search "#{params[:id]}"
            

            
      #       result.each do |res|
      #         res.select("distinct product_id").product.categories.uniq.each do |cat|
      #           cat.spec[cat.id] = cat.name
      #         end
      #       end
          
      #       render :view => 'search'
      #     puts all_spec.inspect

          
      # end

    puts "called search"    
    @result = ThinkingSphinx.search "#{params[:id]}" ,:classes => [P2p::Item,P2p::Product,P2p::Category] 
    #@products.to_json
    puts "--------res" 
    puts @result
    @search_result=[]

    @result.each do |res| 
      puts "#{res} -> #{res.class.to_s}"
       if res.class.to_s == "P2p::Category"
        result_items = {}
        res.products.each do |prod|
          result_items = prod.items.limit(10)
          @search_result += result_items
        end
        # res.items.select("title,price").each do |items|
        #   @search_result << items
        # end
        puts "------->#{result_items}"
       elsif res.class.to_s == "P2p::Product"
        res1=P2p::Item.find(res.category_id)
        @search_result << res1
       else
         @search_result << res
       end
    end
    render :text => @search_result.to_json
  end 

end
