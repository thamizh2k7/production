ActiveAdmin.register Order do
  index do
  	column :id
  	column "Order ID", :random
  	column "User", :user_name do |order|
  		order.user.name
  	end
  	column :order_type
  	column :payment_done
  	column :deposit_total
  	column :rental_total
  	column :gharpay_id
  	column :citruspay_response
  	column :COD_mobile
  end
end
