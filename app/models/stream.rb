class Stream < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  has_many :book_streams
  has_many :books, :through => :book_streams
end
