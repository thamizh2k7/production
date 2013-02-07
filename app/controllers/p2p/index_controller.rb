class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    # @mobiles=P2p::Item.select("title,price").where('product_id=1').limit(4);
    # @electronics=P2p::Item.select("title,price").where('product_id=2').limit(4);
     
    @list = P2p::Category.limit(10).order("priority")

  end

  def search

    puts "called search"

    # result =[]

    res ={}

    # res = P2p::Category.find_by_name(params[:id])

    # unless res.nil?
    #   result.push({:type => "cat" })
    #   temp =[]
    #   res.products.limit(5).each do |prod|
    #       if prod.items.size >0 
    #         temp.push(prod.items.select("title,id,price").first)
    #       end
    #   end
    #   result.push({:payload => temp })

    #   render :json => res

    # end

    

    #search for Category
    result = P2p::Category.search(params[:id])

    temp_res =[]

    unless result.empty?
        res["type"] ="cat"

        result.each do |r|

            cat = r.name

            items =  r.products[0].items.select("id,title,price").limit(10)

            next if items.size == 0  

            temp_item =[]

            items.each do |itm|
              i = itm.get_image(1,1)[0][:url]
              itm = itm.attributes
              itm[:image] = i
              temp_item.push(itm)

              
            end





            temp_res.push(:cat => cat , :items => temp_item )

        end 

          res["data"] = temp_res   
        

        render :json => res
        return
    end

    #search for product
    result = P2p::Product.search(params[:id])

    temp_res =[]

    

    unless result.empty?
        res["type"] ="pro"

        cat_done =[]

        result.each do |r|

            cat = r.category.name

            puts " in " + r.category.id.to_s

            next  if cat_done.include?(r.category.id) 

            cat_done.push( r.category.id)

            #temp = r.items.select("id,title,price").search(params[:id])

            #puts r.inspect + " category "

            #if temp.size == 0
              items =  r.items.select("id,title,price").limit(10)
#              puts temp.inspect + " selected "
 #           else
  #            items = temp
   #           puts temp.inspect + " selected "
#            end


            next if items.size == 0  

            temp_item =[]

            items.each do |itm|
              i = itm.get_image(1,1)[0][:url]
              itm = itm.attributes
              itm[:image] = i
              temp_item.push(itm)

              
            end





            temp_res.push(:cat => cat , :items => temp_item )

        end 

          res["data"] = temp_res   
        

        render :json => res
        return
    end

    
    #search for items
    result = P2p::Item.select("title").search(params[:id] ,:star => true ,:match_mode => :any)

    unless result.empty?
        
      #   res["type"] ="redirect"
      #   res["data"] = "/p2p/view/" + result[0].id.to_s

      #   render :json => res
      #   return

      # end

        result.each do |r|
          r[:image] = r.get_image(1,1)[0][:url]
        end

        res["type"] ="item"
        res["data"] = result

        render :json => res
        return
    end
    
    
    render :json => []

  #   @result = ThinkingSphinx.search "*#{params[:id]}*" ,:classes => [P2p::Item,P2p::Product,P2p::Category] 
  #   #@products.to_json
  #   puts "--------res" 
  #   puts @result
    
  #    @search_result=[]
  #    @items_from_category={}
  #    @items_from_product=[]
  #    @items_from_search=[]

  #   @result.each do |res| 
      
  #     puts "#{res} -> #{res.class.to_s}"
      
  #      if res.class.to_s == "P2p::Category"
  #       result_items = {}
  #       temp=[]
  #       puts"category-name: #{res.name}"
  #       res.products.each do |prod|
  #         result_items = prod.items.select("title,price").limit(10)
  #         #@search_result += result_items
  #         temp+= result_items
          
  #       end
  #         @items_from_category=["#{res.name}"=>temp]
  #         puts "------->#{result_items}"
  #      elsif res.class.to_s == "P2p::Product"
  #       res1=P2p::Item.select("title,price").find(res.category_id)
  #       if res1.nil?
  #         @items_from_product+=res1
  #       end
  #       #@search_result << res1

  #      else

  #       @items_from_search << res
  #       # @search_result << res
  #      end

  #      @search_result={:category=>@items_from_category,:prducts=>@items_from_product,:items=>@items_from_search }


  # end


  #   render :text => @search_result.to_json
  # end 
  end


end
