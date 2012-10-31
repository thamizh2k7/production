class Publisher < ActiveRecord::Base
  attr_accessible :rental, :name, :books_attributes

  has_many :books

  accepts_nested_attributes_for :books, :allow_destroy => true
end
