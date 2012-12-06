class Semester < ActiveRecord::Base

	has_many :book_semesters
  has_many :books, :through => :book_semesters

  attr_accessible :name
end
