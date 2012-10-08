class Book < ActiveRecord::Base
  attr_accessible :name, :description, :isbn10, :image_attributes, :book_image, :author, :isbn13, :binding, :publisher, :published, :pages, :price, :age, :strengths, :weaknesses, :category_id, :edition, :new_book_price, :old_book_price
  attr_accessor :book_image

  has_many :images
  has_many :reviews

  belongs_to :category

  has_many :book_carts
  has_many :carts, :through => :book_carts

  has_many :book_orders
  has_many :orders, :through => :book_orders

  accepts_nested_attributes_for :images

  define_index do
  	indexes :name, :sortable => true
    indexes :author
    indexes :isbn10

    set_property :enable_star => 1
    set_property :min_infix_len => 2

  end

	def book_image
  	unless self.images.count == 0
      self.images.first.image(:book)
    else
      "/assets/book.jpeg"
    end
  end

  def as_json(options = { })
  	h = super(options)
    # adding virtual attributes to the json
    h[:book_image] = book_image
    # returning the new json
    h
  end
end