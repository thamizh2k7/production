class P2p::User < ActiveRecord::Base
  belongs_to :user ,:class_name => "::User" 
  
  attr_accessible :mobileverified, :user_id

  has_many :items
  has_many :credits


  
end
