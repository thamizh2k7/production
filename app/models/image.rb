class Image < ActiveRecord::Base
	attr_accessible :image, :image_url
	attr_accessor :image_url

	before_validation :download_remote_image, :if => :image_url_provided?

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :book => "130x160>" }

  belongs_to :imageable, :polymorphic => true

  def image_url_provided?
    !self.image_url.blank?
  end

  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
	  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

  def download_remote_image
    self.image = do_download_remote_image
    self.image_url = image_url
  end

  rails_admin do
		base do
			fields :image
		end
		visible false
	end
end
