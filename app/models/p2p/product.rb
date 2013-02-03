class P2p::Product < ActiveRecord::Base

  attr_accessible :name, :category_id ,:priority

  belongs_to :category
  has_many :items
  
  
end
