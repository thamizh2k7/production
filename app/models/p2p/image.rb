require 'open-uri'

class P2p::Image < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :img
  has_attached_file :img , :styles => { :view => "320X240", :thumb => "57X57" ,:search => "120X120" ,:full => "640X480" },
  					:default_url => '/assets/noimage.jpg'

  belongs_to :item

  validates :img, :attachment_presence => true 

  def picture_from_url(url)
    self.img = open(url)
  end
end
