class General < ActiveRecord::Base
  attr_accessible :general_images_attributes

  has_many :general_images

  accepts_nested_attributes_for :general_images, :allow_destroy => true
end