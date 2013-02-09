class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    # @mobiles=P2p::Item.select("title,price").where('product_id=1').limit(4);
    # @electronics=P2p::Item.select("title,price").where('product_id=2').limit(4);
     
    @list = P2p::Category.limit(10).order("priority")

  end

  def search

    puts "called search"

    res ={}


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

  end

  def search_cat

    if params[:prod].present?
          @cat = P2p::Category.find_by_name(params[:cat])
          @products = @cat.products.find_by_name(params[:prod])
          @prod_name = @products.name
          @items = @products.items.all
          
    else
      @cat = P2p::Category.find_by_name(params[:cat])
      @cat_name = @cat.name
      @products = @cat.products.limit(5)

    end
    

  end

end

