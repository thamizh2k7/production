class P2p::Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
<<<<<<< HEAD
  has_many :attrs , :class_name => "ItemAttributes"

  belongs_to :city
  
  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price ,:location

=======
  #belongs_to :product
  has_many :item_attributes
  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount ,:price
 define_index do
    indexes :title
    set_property :enable_star =>1 
    set_property :min_infix_len =>3
  end
>>>>>>> p2p_searchForm
end
