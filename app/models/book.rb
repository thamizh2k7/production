class Book < ActiveRecord::Base
  attr_accessible :name, :description, :isbn10, :images_attributes, :book_image, :author, :isbn13, :binding, :published, :pages, :price, :age, :strengths, :weaknesses, :category_id, :edition, :new_book_price, :old_book_price, :book_original, :rank, :rental_price, :publisher_id, :class_adoptions_attributes, :reviews_attributes, :published_date, :book_colleges_attributes, :book_streams_attributes, :book_semesters_attributes,:availability
  attr_accessor :book_image, :book_original, :published_date

  has_many :images, :as => :imageable
  has_many :reviews

  belongs_to :category
  belongs_to :publisher

  has_many :book_carts
  has_many :carts, :through => :book_carts

  has_many :book_orders
  has_many :orders, :through => :book_orders

  has_many :class_adoptions, :dependent => :destroy
  has_many :book_colleges
  has_many :book_streams
  has_many :book_semesters

  accepts_nested_attributes_for :images, :class_adoptions, :reviews, :book_colleges, :book_streams, :book_semesters, :allow_destroy => true

  after_create do |book|
    r = Random.new
    rank = r.rand(50..100)
    book.update_attributes(:rank => rank)
  end

  define_index do
  	indexes :name, :sortable => true
    indexes :author
    indexes :isbn10

    set_property :min_infix_len => 2
    set_property :delta =>true

  end

	def book_image
  	unless self.images.count == 0
      self.images.first.image(:book)
    else
      "/assets/book.jpeg"
    end
  end

  def book_original
    unless self.images.count == 0
      self.images.first.image(:original)
    else
      "/assets/book.jpeg"
    end
  end

  def published_date
    published = self.published
    published_date = published.gsub(" ","")
    published_date = published.gsub("/",",")
    if /^\d{4}\,\d{2}\,\d{2}$/.match published_date
      date = Date.strptime("{#{published_date}}", "{%Y,%m,%d}")
    elsif /^\d{4}\,\d{2}$/.match published_date
      date = Date.strptime("{#{published_date}}", "{%Y,%m}")
    elsif /^\d{4}$/.match published_date 
      date = Date.strptime("{#{published_date}}", "{%Y}")
    end
    date
  end

  def as_json(options = { })
  	h = super(options)
    # adding virtual attributes to the json
    h[:book_image] = book_image
    h[:book_original] = book_original
    h[:published_date] = published_date
    # returning the new json
    h
  end

  rails_admin do
    include_all_fields
    field :published do
      label "Publised (YYYY/MM/DD) OR (YYYY/MM) OR (YYYY)"
    end
    field :carts do
      visible false
    end
    field :orders do
      visible false
    end
  end

end