class Ambassador < ActiveRecord::Base
  belongs_to :college
  has_many :users
  
  attr_accessible :name, :college_id
end
