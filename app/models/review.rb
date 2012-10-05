class Review < ActiveRecord::Base
  attr_accessible :text, :rating

  belongs_to :book
  belongs_to :user
end
