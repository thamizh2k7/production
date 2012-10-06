class GeneralImage < ActiveRecord::Base
  attr_accessible :image

  belongs_to :general
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
