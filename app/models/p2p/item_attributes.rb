class P2p::ItemAttributes < ActiveRecord::Base
  belongs_to :attr ,:class_name => 'P2p::Attribute' ,:foreign_key => "attribute_id"
  belongs_to :item
  attr_accessible :value 
end
