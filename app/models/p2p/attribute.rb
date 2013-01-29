class P2p::Attribute < ActiveRecord::Base
  attr_accessible :display_type, :name, :parent_id
  belongs_to :category
  
end
