class Bank < ActiveRecord::Base
  attr_accessible :bank_name, :details
  has_many :orders
end
