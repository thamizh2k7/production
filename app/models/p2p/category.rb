class P2p::Category < ActiveRecord::Base
  attr_accessible :name, :category_id,:priority

  belongs_to :category , :class_name => "P2p::Category"
  
  define_index do
    indexes :name
    indexes p2p_products(:name), :as=> :product_name
    has created_at,updated_at
  end

end
