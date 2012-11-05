class CompanyUser < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  attr_accessible :user_id

  rails_admin do
		visible false
	end
end
