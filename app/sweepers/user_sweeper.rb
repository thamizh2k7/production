class UserSweeper < ActionController::Caching::Sweeper
  observe P2p::User

  def after_save(user)
  	expirepage(user)
  end

  def after_update(user)
  	expirepage(user)
  end

  def expirepage(user)
    
  end
end