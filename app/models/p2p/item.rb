class P2p::Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount
end
