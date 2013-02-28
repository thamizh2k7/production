class P2p::ItemDelivery < ActiveRecord::Base
		belongs_to :item , :class_name=>"P2p::Item", :foreign_key=>'p2p_item_id'
   attr_accessible :txn_id,:courier_name, :tracking_no,:shipping_date, :shipping_charge,:delivery_date,:citrus_pay_id,:commission, :citrus_reason, :citrus_ref_no
end
