class College < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  has_many :orders, :through => :users
end
