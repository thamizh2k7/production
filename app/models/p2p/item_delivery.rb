class P2p::ItemDelivery < ActiveRecord::Base
		belongs_to :item , :class_name=>"P2p::Item"
   attr_accessible :courier_name, :tracking_no,:shipping_date, :shipping_charge,:delivery_date,:citrus_pay_id,:commission
end
