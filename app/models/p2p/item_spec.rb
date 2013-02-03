class P2p::ItemSpec < ActiveRecord::Base

  belongs_to :spec
  belongs_to :item
  attr_accessible :value   
end
