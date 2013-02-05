class P2p::Message < ActiveRecord::Base
  attr_accessible :item_id, :message, :messagetype, :readdatetime, :receiver, :sender, :flag, :sender_status
  
  
  # Associations to User
  belongs_to :sender, :class_name=>'P2p::User', :foreign_key=>'sender_id'
  belongs_to :receiver, :class_name=>'P2p::User', :foreign_key=>'receiver_id'

  # scopes to the messages
  scope :inbox, where("flag = 'unread' or flag = 'read'")
  scope :sent, where(:sender_status=>"sent")
end
