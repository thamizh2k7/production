class P2p::ItemsController < ApplicationController


  before_filter :p2p_user_signed_in ,:except => [:view]
  layout :p2p_layout

  def new
   @item = P2p::Item.new

  end


  def create
    @v = params["item"]['attribute']

    item = P2p::User.find(current_user.id).items.new({:title => params["title"], :desc => params["desc"], :price => params["price"]})

    item.product = P2p::Product.find(params["item"]["brand"].to_i)

    #echo params["item"]['attribute'].count
    
     params["item"]['attribute'].each do |key,value|
      
       attr = P2p::ItemSpec.new
       attr.spec = P2p::Spec.find(key.to_i)
       attr.value = value
       item.specs << attr
     end

    if item.save 
      redirect_to "/p2p"
    else
      flash.now[:notice] = "Cannot Create Item. Try again"
      render :new
    end


  end

  def update
  end

  def destroy
    item = P2p::Item.find(params[:id])
    item.delete
    redirect_to '/p2p/mystore'
  end

  def edit
  end

  def get_attributes
    cat = P2p::Category.find(params[:id])
    @attr = cat.specs.select("id,name,display_type")

  #  render :json => @attr
  end

  def get_brands
    cat =P2p::Category.find(params[:id]) 
    brand  = cat.products.select("id,name")
    render :json => brand
  end


  def get_sub_categories
    cat = P2p::Category.select("id,name").where("category_id = " + params[:id])
    render :json => cat
  end


  def view


      @item = P2p::Item.find(params[:id])

     @attr = @item.specs(:includes => :attr)

      if current_user.nil?
        @item.viewcount= @item.viewcount.to_i + 1
      end

    @item.save 
    
  end

  def inventory
    user = P2p::User.find(current_user)

    if params[:query].present? 

      if params[:query] == "sold"
        @items = user.items.sold
      end

    else

      @items = user.items.notsold
      
    end
    
  end

  def sold
      @item = P2p::Item.find(params[:id])
      @item.solddate =Time.now
      @item.save

      redirect_to '/p2p/view/' + @item.id.to_s

  end

  def add_image


    item = P2p::Item.find(params["item_id"])
    unless params["img"].nil?


      params["img"].each do |img|

        i = item.images.new(:img=>img)

        i.save

      end

    end
    #render :inline => params.inspect

    redirect_to '/p2p/view/' + params[:item_id]

  end

end
