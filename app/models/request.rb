class Request < ActiveRecord::Base
  belongs_to :user
  attr_accessible :author, :isbn, :title, :user_id
end
