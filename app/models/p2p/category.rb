class P2p::Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  has_many :products
  has_many :attrs , :class_name => "Attribute" 
  belongs_to :parent_category , :class_name => "P2p::Category" , :foreign_key => "parent_id"
end
