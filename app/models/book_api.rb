class BookApi < ActiveRecord::Base
  attr_accessible :book, :author, :isbn, :isbn13, :binding, :publishing_date, :publisher, :edition, :number_of_pages, :language,:image_url

end
