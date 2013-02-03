class P2p::Spec < ActiveRecord::Base
  attr_accessible :display_type, :name ,:category_id ,:priority
  belongs_to :category

  define_index do
    indexes :name
    has created_at,updated_at
  end
  
end
