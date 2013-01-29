class P2p::Credit < ActiveRecord::Base
  belongs_to :user
  attr_accessible :available, :totalCredits, :type
end
