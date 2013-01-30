class P2p::ItemsController < ApplicationController


  before_filter :p2p_user_signed_in
  layout :p2p_layout

  def new
   @item = P2p::Item.new

   @attr = P2p::Attribute.all

  end

  def create
    @v = params
  end

  def update
  end

  def destroy
  end

  def edit
  end
end
