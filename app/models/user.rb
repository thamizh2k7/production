class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :is_admin, :college_id, :mobile_number

  has_many :reviews, :dependent => :destroy
  has_one :cart, :dependent => :destroy

  has_many :requests, :dependent => :destroy
  has_many :orders, :dependent => :destroy

  belongs_to :college

  after_create do |user|
    user.create_cart()
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    resp = {}
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
    resp[:new_user] = false
	  unless user
      resp[:new_user] = true
	    user = User.create(name:auth.extra.raw_info.name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
	                         password:Devise.friendly_token[0,20]
	                         )
	  end
    resp[:user] = user.id
	  resp.to_json()
	end

	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end