class P2p::Message < ActiveRecord::Base
  attr_accessible :item_id, :message, :messagetype, :readdatetime, :receiver, :sender
end
