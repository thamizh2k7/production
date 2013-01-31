class P2p::Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  has_many :items
  has_many :products
  has_many :attrs , :class_name => "Attribute" 
  belongs_to :parent_category , :class_name => "P2p::Category" , :foreign_key => "parent_id"
  
  define_index do
    indexes :name
    indexes p2p_products(:name), :as=> :product_name
    has created_at,updated_at
  end

end
