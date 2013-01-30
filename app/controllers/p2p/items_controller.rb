class P2p::ItemsController < ApplicationController


  before_filter :p2p_user_signed_in
  layout :p2p_layout

  def new
   @item = P2p::Item.new

   

  end

  def create
    @v = params["item"]['attribute']

    item = P2p::User.find(current_user.id).items.new(params["p2p_item"])

    item.category = P2p::Category.find(params["item"]["category"])

    #echo params["item"]['attribute'].count
    
     params["item"]['attribute'].each do |key,value|
      puts key + "   " + value

       attr = P2p::ItemAttributes.new
       attr.attr = P2p::Attribute.find(key.to_i)
       attr.value = value
       item.attrs << attr
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
  end

  def edit
  end

  def get_attributes
    cat = P2p::Category.find(params[:id])
    @attr = cat.attrs.select("id,name,display_type")

  #  render :json => @attr
  end

  def get_sub_categories
    cat = P2p::Category.select("id,name").where("parent_id = " + params[:id])
    render :json => cat
  end

end
