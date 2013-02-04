class P2p::Item < ActiveRecord::Base


  belongs_to :product
  belongs_to :user
  belongs_to :city
  has_many :specs


  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price
  
 define_index do
    indexes :title
    has created_at,updated_at
  end

end
