class P2p::Image < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :img
  has_attached_file :img , :styles => { :medium => "275x300", :thumb => "100x100" }

  belongs_to :item

  validates :img, :attachment_presence => true 

  
end
