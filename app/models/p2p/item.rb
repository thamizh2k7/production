class P2p::Item < ActiveRecord::Base


  belongs_to :product
  belongs_to :user
  belongs_to :city
  has_many :specs ,:class_name => "P2p::ItemSpec"



  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price


  default_scope where('deletedate is null')

  scope :sold , where('solddate is not null')

  scope :notsold , where('solddate is null')
  
 define_index do
    indexes :title
    
    has created_at,updated_at
  end

end
