class Ambassador < ActiveRecord::Base

  has_and_belongs_to_many :colleges
  has_many :users

  belongs_to :ambassador_manager, :class_name => "User", :foreign_key => "ambassador_manager_id"
  accepts_nested_attributes_for :colleges
  attr_accessible :college_ids, :ambassador_manager_id
end