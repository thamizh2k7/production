class P2p::Item < ActiveRecord::Base


  belongs_to :product
  belongs_to :user
  belongs_to :city
  has_many :specs ,:class_name => "P2p::ItemSpec"

  has_many :images ,:class_name => 'P2p::Image'

  attr_accessible :approvedflag, :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price ,:img

  attr_accessor :img


  default_scope where('deletedate is null')

  scope :sold , where('solddate is not null')

  scope :notsold , where('solddate is null')
  
 define_index do
    indexes :title
    
    has created_at,updated_at
  end

  def get_image(count = 1 ,medium = 1)
    res=[]


    if self.images.count == 0 
      res.push({:url => "/assets/noimage.jpg" ,:id => 0})
    else

      if count == 1  
        if medium ==1 
            res.push  ({:url => self.images.first.img.url(:medium) ,:id =>self.images.first.id.to_s })
        else
          res.push  ({:url => self.images.first.img.url ,:id =>self.images.first.id.to_s })
        end
      else

        self.images.each do |img|
          if medium == 1 
            res.push  ({:url => img.img.url(:medium) , :id => img.id.to_s })
          else
            res.push  ({:url => img.img.url , :id => img.id.to_s })
          end
        end
      end

    end

    res
  end

end
