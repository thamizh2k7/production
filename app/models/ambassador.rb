class Ambassador < ActiveRecord::Base
  belongs_to :college
  has_many :users

  belongs_to :ambassador_manager, :class_name => "User", :foreign_key => "ambassador_manager_id"
  
  attr_accessible :college_id, :ambassador_manager_id

  # accepts_nested_attributes_for :ambassador_manager, :allow_destroy => true

  rails_admin do
  	base do
  		include_all_fields
  		field :ambassador_manager do
  			label "Ambassador"
  		end
  	end
  end
end