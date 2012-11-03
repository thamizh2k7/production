class Ambassador < ActiveRecord::Base
  belongs_to :college
  has_many :users

  belongs_to :ambassador_manager, :class_name => "User", :foreign_key => "ambassador_manager_id"
  
  attr_accessible :college_id

  rails_admin do
  	base do
  		include_all_fields
  		field :ambassador_manager do
  			label "Ambassador"
  		end
  	end
  end
end