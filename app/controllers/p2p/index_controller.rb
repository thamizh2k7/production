class P2p::IndexController < ApplicationController

  layout :p2p_layout

  def index
    # @mobiles=P2p::Item.select("title,price").where('product_id=1').limit(4);
    # @electronics=P2p::Item.select("title,price").where('product_id=2').limit(4);
     
    @list = P2p::Category.order("priority")

  end

def search
  response = get_search_suggestions(params[:id])

  if response.size == 0

  		suggested_word = suggest(params['id'])

  		if suggested_word == params[:id]


      result = P2p::Item.search(suggested_word ,:match_mode => :any ,:star => true)

      result.each do |res|
        response.push({:label=> "#{res.title}" ,:value => "/p2p/search/q/#{res.title}"} )
      end

		else
			response = get_search_suggestions(suggested_word)
		end 

  end
  
  if response.empty?
    render :json => [{:label => "No results found" ,:value => ""}]
  else
    render :json => response
  end
  

end


def get_search_suggestions(query)
	response =[]
	  result = P2p::Category.search(query ,:match_mode => :any ,:star => true)

  result.each do |res|
  	response.push( {:label => "#{query} in #{res.name}" , :value => "/p2p/search/c/#{res.name}"} )
  end


  result = P2p::Product.search(query ,:match_mode => :any ,:star => true)

  result.each do |res|
  	response.push({:label=> "#{query} in #{res.category.name} (#{res.items.count})" ,:value => "/p2p/search/c/#{res.category.name}/#{query}"} ) if res.items.count >0
  end

  result = P2p::Item.search(query ,:match_mode => :any ,:star => true)

  result.each do |res|
  	response.push({:label=> "#{res.title}" ,:value => "/p2p/search/q/#{res.title}"} )
  end
  return response

end  

def search_list

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
              i = itm.get_image(1,:search)[0][:url]
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
              i = itm.get_image(1,:search)[0][:url]
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
          r[:image] = r.get_image(1,:search)[0][:url]
        end

        res["type"] ="item"
        res["data"] = result

        render :json => res
        return
    end
    
    
    render :json => []



  end


	 def search_cat
	      @cat = P2p::Category.find_by_name(params[:cat])
	      @cat_name = @cat.name

        if params.has_key?("prod")
          
          @products =[]
          res = P2p::Item.search(params[:prod], :match_mode=> :any , :star => true)

          res.each do |r|
            @products.push(r.product) unless @products.include?(r.product)
          end

          @cat.products.find_all_by_name(params[:prod]).each do |r|
            @products.push(r) unless @products.include?(r)
          end


        else

	       @products = @cat.products
        end
	end
	
	def suggest(query_word) 
		speller = Aspell.new("en_US")
		speller.suggestion_mode = Aspell::ULTRA

		query_word.split(" ").each do |word| 
		  if !speller.check(word) 
		    query_word.gsub! word , speller.suggest(word).first
    	  end
		end

    query_word
	end


	def browse
		@cat = P2p::Category.find_by_name(params[:cat])
		if params.has_key?("prod") 
			@products=@cat.products.find_by_name(params[:prod])

			if @products.nil?
				@cat = P2p::Category.find_by_name(params[:prod])
				@products=@cat.products
				params.delete("prod")
			end
		else
			@products=@cat.products

      if @products.empty? and !@cat.subcategories.nil?

          @cat.subcategories.each do |cat|
            @products +=cat.products
          end

      end
		end

	end

 end