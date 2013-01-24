class Bank < ActiveRecord::Base
  attr_accessible :name, :details
  has_many :orders
end
