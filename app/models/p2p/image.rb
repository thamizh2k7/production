class P2p::Image < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :img
  has_attached_file :img , :styles => { :view => "275x275", :thumb => "50X50" }

  belongs_to :item

  validates :img, :attachment_presence => true 

  
end
