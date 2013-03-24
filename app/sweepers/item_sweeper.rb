class ItemSweeper < ActionController::Caching::Sweeper
  observe P2p::Item

  def after_save(item)
  	expirepage(item)
  end

  def after_update(item)
  	expirepage(item)
  end

  def expirepage(item)

      expire_page :controller => 'index' , :action => 'index'
      #expire_action :controller => 'index' , :action => 'search' 
      expire_action :controller => 'index' , :action => 'seller_items' , :id => item.user.id ,:name => item.user.user.name

      expire_page :controller => 'index' , :action => 'search_cat' , :cat => item.category.name
      expire_page :controller => 'index' , :action => 'browse_filter' ,:cat => item.category.name ,:prod => item.product.name
      expire_page :controller => 'index' , :action => 'browse' ,:cat => item.category.name
      expire_page :controller => 'index' , :action => 'browse' ,:cat => item.category.name ,:prod => item.product.name

  end
end