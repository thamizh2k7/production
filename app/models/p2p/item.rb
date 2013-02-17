class P2p::Item < ActiveRecord::Base


  belongs_to :product
  belongs_to :user
  belongs_to :city
  has_many :specs ,:class_name => "P2p::ItemSpec"
 
  has_many :messages ,:class_name => 'P2p::Message'
  
  has_one :category ,:through => :product

  has_many :images ,:class_name => 'P2p::Image'

  attr_accessible :approveddate, :disapproveddate , :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price ,:img,:condition

  attr_accessor :img

  # validates :title ,:uniqueness => true  if :new_record?

  default_scope where('deletedate is null and approveddate is not null')

  scope :notapproved , where('approveddate is null')
  scope :disapproved , where('disapproveddate is  not null')

  scope :sold , where('solddate is not null')

  scope :notsold , where('solddate is null')
  
 define_index do
    indexes :title
    
    has created_at,updated_at
  end


  def get_image(count = 1, type=:view)
    res=[]

    if self.images.count == 0 
        if type  == :view
          res.push({:url => "/assets/p2p/noimage_view.jpg" ,:id => 0})
        elsif type == :thumb
          res.push({:url => "/assets/p2p/noimage_thumb.jpg" ,:id => 0})
        elsif type == :search 
          res.push({:url => "/assets/p2p/noimage_search.jpg" ,:id => 0})
        end
      
    else

      unless self.images.first.img.exists?
        if type  == :view
          res.push({:url => "/assets/p2p/noimage_view.jpg" ,:id => 0})
        elsif type == :thumb
          res.push({:url => "/assets/p2p/noimage_thumb.jpg" ,:id => 0})
        elsif type == :search 
          res.push({:url => "/assets/p2p/noimage_search.jpg" ,:id => 0})
        end

        return res
      end

      img = self.images

      if count == 1  
        res.push ({:url => img.first.img.url(type) , :id => img.first.id.to_s })
      else
        img.each do |img|
          unless img.img.exists?
    
            if type  == :view
              res.push({:url => "/assets/p2p/noimage_view.jpg" ,:id => 0})
            elsif type == :thumb
              res.push({:url => "/assets/p2p/noimage_thumb.jpg" ,:id => 0})
            elsif type == :search 
              res.push({:url => "/assets/p2p/noimage_search.jpg" ,:id => 0})
            end

          end

          res.push ({:url => img.img.url(type) , :id => img.id.to_s })
        end
      end

      res
    end
  end

end
