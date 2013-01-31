class P2p::Attribute < ActiveRecord::Base
  attr_accessible :display_type, :name, :parent_id
  belongs_to :category
  define_index do
    indexes :name
    has created_at,updated_at
  end
end
