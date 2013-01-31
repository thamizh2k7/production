class P2p::Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :attrs , :class_name => "ItemAttributes"

  belongs_to :city
  
  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price ,:location

end
