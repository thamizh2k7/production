#todo check approving and not approving conditions...
# must not be sold,, must be finished..

#spec which are for notapproved and not done must not appear

class P2p::Item < ActiveRecord::Base


  belongs_to :product
  belongs_to :user
  belongs_to :city
  has_many :specs ,:class_name => "P2p::ItemSpec"
 
  has_many :messages ,:class_name => 'P2p::Message'
  
  has_one :category ,:through => :product

  has_many :images ,:class_name => 'P2p::Image'

  attr_accessible :approveddate, :disapproveddate , :delivereddate, :desc, :paiddate, :paytype, :reqCount, :solddate, :title, :viewcount, :price ,:img,:condition, :deletedate , :payinfo,:commision

  # 1- courier
  # 2- direct
  # 3 -online

  attr_accessor :img


  # validates :title ,:uniqueness => true  if :new_record?

  default_scope where("deletedate is null and paytype is not null"  )



  scope :by_location_or_allover , lambda { |location|
    if location !=""
      where ("(city_id = #{location} or (paytype=1 and payinfo ='1' ))")
    else
      return 
    end
    
  }

  scope :approved , where('approveddate is not null')
  scope :notapproved , where('approveddate is null')
  scope :disapproved , where('disapproveddate is  not null')
  scope :notdisapproved , where('disapproveddate is  null')

  scope :waiting , where('approveddate is null and disapproveddate is null')

  scope :deleted , where('deletedate is not  null')
  scope :notdeleted , where('deletedate is null')
  
  scope :notfinished , where(' deletedate is null and paytype is null')

  scope :sold , where('solddate is not null')

  scope :notsold , where('solddate is null')
  
 define_index do

    #where ('deletedate is not null and paytype is not null and solddate is null')
    where ('deletedate is null and paytype is not null and solddate is null')
    indexes :title  
    


  end

  after_create :publish_to_stream

  def publish_to_stream

    message_notification = "
         $('#notificationcontainer').notify('create', 'new_item_notification', {
              title: '#{self.title}',
              msg: 'Your new listing has been sent to verification and will be approved quite soon'
          });
      "

    admin_message_notification = "
         $('#notificationcontainer').notify('create',  {
              title: 'New Listing waiting for approval ',
              text: '#{self.user.user.name}  has listed #{self.title} , and is waiting for your approval '
          });
      "

    PrivatePub.publish_to("/user_#{self.user.id}", message_notification )
    PrivatePub.publish_to("/user_1", admin_message_notification )

    P2p::User.find(1).sent_messages.create({:receiver_id => self.user.id ,
                                              :message => 'This is an auto generated system message. Your listing is kept under verification and will appear on the site with in 2hours. To send a message to me just click compose and send your message. <br/> Thank you.. <br/> Sincerly, <br/> Admin - Sociorent',
                                              :messagetype => 5,
                                              :sender_id => 1,
                                              :sender_status => 2,
                                              :receiver_status => 0,
                                              :parent_id => 0
                                              });
    puts self.inspect + "self"

    prod_url = URI.encode("/p2p/#{self.category.name}/#{self.product.name}/#{self.title}")
    P2p::User.find(1).sent_messages.create({:receiver_id => 1 ,
                                              :message => "This is an auto generated system message. #{self.user.user.name} (#{self.user.user.email}) has listed a new item and is waiting for your verification. Listing link - <a href='#{prod_url}'>#{self.title}</a>. <br/> Thank you.. <br/> Sincerly, <br/> Developers",
                                              :messagetype => 5,
                                              :sender_id => 1,
                                              :sender_status => 2,
                                              :receiver_status => 0,
                                              :parent_id => 0
                                              });



  end


  def get_image(count = 1, type=:view)
    res=[]


    if self.images.nil?
        if type  == :view
          res.push({:url => "/assets/p2p/noimage_view.jpg" ,:id => 0})
        elsif type == :thumb
          res.push({:url => "/assets/p2p/noimage_thumb.jpg1" ,:id => 0})
        elsif type == :search 
          res.push({:url => "/assets/p2p/noimage_search.jpg" ,:id => 0})
        end
      return res
    end

    if self.images.count == 0 
        if type  == :view
          res.push({:url => "/assets/p2p/noimage_view.jpg" ,:id => 0})
        elsif type == :thumb
          res.push({:url => "/assets/p2p/noimage_thumb.jpg2" ,:id => 0})
        elsif type == :search 
          res.push({:url => "/assets/p2p/noimage_search.jpg" ,:id => 0})
        end
      
    else

      unless self.images.first.img.exists?
        if type  == :view
          res.push({:url => "/assets/p2p/noimage_view.jpg" ,:id => 0})
        elsif type == :thumb
          res.push({:url => "/assets/p2p/noimage_thumb.jpg3" ,:id => 0})
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
              res.push({:url => "/assets/p2p/noimage_thumb.jpg4" ,:id => 0})
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
