ActiveAdmin.register Order do
  scope :All
  scope :New
  scope :Approved
  scope :Shipped
  scope :Cancelled
  scope :Partially_Cancelled
  config.clear_action_items!
  actions :all, :except => [:edit]
  index do
  	selectable_column
  	column "Order ID", :random
  	column "User", :user_name do |order|
  		order.user.name
  	end
  	column :order_type
  	column :deposit_total
  	column :COD_mobile
    column "Order Date",:created_at
    default_actions
  end

  show do |order|
    attributes_table do
      row :id
      row :user_name do 
        order.user.name
      end
      row :order_type
      row :deposit_total
      row :COD_mobile
      row :created_at do 
        order.created_at
      end
      row :items do
        #TODO : Print it Neatly
        order.books.select("name, isbn13").each do |b|
        end
      end
      row :status
    end
  end

  member_action :shipping_order_form do 
    @order = Order.find(params[:id])
    @dates = @order.book_orders.select("DISTINCT(shipped_date)").pluck(:shipped_date)
    @book_orders = @order.book_orders.where(:shipped => false)
  end
  member_action :cancel_order_form, :method => :get do
    @order = Order.find(params[:id])
    @book_orders=@order.book_orders.where("status IS NULL or status= 'unshipped'")
  end
  member_action :cancel_order, :method=>:post do 
    scope="all"
    order= Order.find(params[:id])
    if params[:book_order]
      book_order_ids = params[:book_order]
      book_order_ids.each do |id, value|
        book_order = BookOrder.find(id.to_i)
        if book_order
          book_order.update_attributes(:status => "cancel")
        end
      end
      if order.book_orders.where(:status=>"cancel").count == order.book_orders.count
        scope="cancelled"
        order.update_attributes(:status=>"cancel")
      else
        order.update_attributes(:status=>"partial_cancel")
        scope="partially_cancelled"
      end
      flash[:notice] = "OrderItems Cancelled Successfully!"
    end
    redirect_to :action => :index,:scope=>scope
  end


  member_action :approve_order, :method=>:get do 
    @order = Order.find(params[:id])
    @order.status = 'approved'
    @order.save
    @order.books.update_all({:status => 'unshipped'}, ["status != 'shipped'"])
    flash[:notice] = "Order Approved Successfully!"
    redirect_to :action => :index, :scope =>"approved"
  end

  action_item :only => [:show] do
    link_to('Shipping Details',shipping_order_form_admin_order_path(order))
  end

  action_item :only => [:show] do
    link_to('Approve Order',approve_order_admin_order_path(order))
  end

  action_item :only => [:show] do
    link_to('Cancel Order',cancel_order_form_admin_order_path(order))
  end

  member_action :shipping_order, :method=>:post do 
    @order= Order.find(params[:id])
    if params[:book_order]
      book_order_ids = params[:book_order]
      book_order_ids.each do |id, value|
        book_order = BookOrder.find(id.to_i)
        if book_order
          book_order.update_attributes(:shipped => true, :status => "shipped", :shipped_date=>Time.now, :tracking_number => params[:tracking_number], :courier_name => params[:courier_name])
        end
      end
      if book_order_ids.count > 0
        msg = "Your Sociorent.com Order #{@order.random} has been shipped through #{params[:courier_name]} with tracking number #{params[:tracking_number]} . Thank you."
        send_sms(@order.user.mobile_number ,msg)
        puts msg
      end
      @order.update_attributes(:status => "shipped") if @order.book_orders.where(:shipped => false).count == 0
      flash[:notice]="Checked books are marked as shipped"
    end
    redirect_to :action => :index, :scope=>"shipped"
  end
end
