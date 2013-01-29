class P2p::ItemAttributes < ActiveRecord::Base
  belongs_to :attribute
  belongs_to :item
  attr_accessible :value
end
