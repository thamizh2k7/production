class Street::ItemDeliveriesController < ApplicationController

  #before_filter :p2p_is_admin

  layout :p2p_layout

  # GET /p2p/item_deliveries
  # GET /p2p/item_deliveries.json
  def index
    @p2p_item_deliveries = P2p::ItemDelivery.order('updated_at desc').paginate(:page => params[:page] ,:per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @p2p_item_deliveries }
    end
  end

  # GET /p2p/item_deliveries/1
  # GET /p2p/item_deliveries/1.json
  def show
    @p2p_item_delivery = P2p::ItemDelivery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @p2p_item_delivery }
    end
  end

  # GET /p2p/item_deliveries/new
  # GET /p2p/item_deliveries/new.json
  def new
    @p2p_item_delivery = P2p::ItemDelivery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @p2p_item_delivery }
    end
  end

  # GET /p2p/item_deliveries/1/edit
  def edit
    begin
      @p2p_item_delivery = p2p_current_user.soldpayments.find(params[:id])

      rescue
        begin
         @p2p_item_delivery = p2p_current_user.payments.find(params[:id])

        rescue Exception => e
          redirect_to '/street'
          return
        end

    end

  end

  # POST /p2p/item_deliveries
  # POST /p2p/item_deliveries.json
  def create
    @p2p_item_delivery = P2p::ItemDelivery.new(params[:p2p_item_delivery])

    respond_to do |format|
      if @p2p_item_delivery.save
        format.html { redirect_to @p2p_item_delivery, notice: 'Item delivery was successfully created.' }
        format.json { render json: @p2p_item_delivery, status: :created, location: @p2p_item_delivery }
      else
        format.html { render action: "new" }
        format.json { render json: @p2p_item_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /p2p/item_deliveries/1
  # PUT /p2p/item_deliveries/1.json
  def update
    @p2p_item_delivery = P2p::ItemDelivery.find(params[:id])

    unless params[:p2p_item_delivery].has_key?(:p2p_item_delivery_shipping_date) and params[:p2p_item_delivery][:p2p_item_delivery_shipping_date] !=""
      params[:p2p_item_delivery][:p2p_status]= 7
    end

    unless params[:p2p_item_delivery].has_key?(:p2p_item_delivery_shipping_date) and params[:p2p_item_delivery][:p2p_item_delivery_shipping_date] !=""
      params[:p2p_item_delivery][:p2p_status]= 7
    end

    respond_to do |format|
      if @p2p_item_delivery.update_attributes(params[:p2p_item_delivery])
        format.html { redirect_to '/street/paymentdetails', notice: 'Item delivery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: 'p2p/paymentdetails', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /p2p/item_deliveries/1
  # DELETE /p2p/item_deliveries/1.json
  def destroy
    @p2p_item_delivery = P2p::ItemDelivery.find(params[:id])
    @p2p_item_delivery.destroy

    respond_to do |format|
      format.html { redirect_to street_item_deliveries_url }
      format.json { head :no_content }
    end
  end



  def print_invoice
  end

  def print_invoice_label
    if !params.has_key?(:id) or params[:id].nil?  or !params.has_key?(:type)
      redirect_to '/street/dashboard/'
      return
    end

    if params.has_key?(:bought)
      @payment = p2p_current_user.payments.find(params[:id])
    else
      @payment = p2p_current_user.soldpayments.find(params[:id])
    end

    if @payment.nil?
      redirect_to '/street/dashboard'
      return
    end



     @address = "#{@payment.buyer.user.name}<br/>"
     addr=JSON.parse @payment.shipping_address
     addr.each do |k,v|
       @address += "#{v}<br/>"
     end

     @address = @address.html_safe

     @senderaddress ="#{@payment.item.user.user.name}<br/>" 
     addr=JSON.parse @payment.item.user.user.address
     addr.each do |k,v|
       @senderaddress += "#{v}<br/>"
     end

     @senderaddress = @senderaddress.html_safe

    if params[:type] == 'invoice'
        #capture the html in variable
        html = render :partial => '/street/item_history/invoice' ,:layout => false
    elsif params[:type] == 'label'
        html = render :partial => '/street/item_history/label' ,:layout => false
    else
      redirect_to '/street/dashboard/'
      return
    end


    #send the html to pdfkit
    kit = PDFKit.new(html[0], :page_size => 'A4')

    #send the stylesheets with absolute paths
    kit.stylesheets <<  Rails.root.join('app/assets/stylesheets/p2p/invoice.css')
    kit.stylesheets <<  Rails.root.join('app/assets/stylesheets/global/bootstrap.min.css')

    #temp file path
    path = (Rails.root.join("tmp/order_#{@payment.id}")).to_s

    #save the pdf
    kit.to_file(path)

    if params[:type] == 'label'
      label = "Package Label for Order #{@payment.id}"
    elsif params[:type] == 'invoice'
      label = "Package Invoice for Order #{@payment.id}"
    end

    #send the pdf
    #send_data( kit.to_pdf,:type => "application/pdf", :filename => "Order #{@payment.id}")
    send_file( path,:type => "application/pdf", :filename => label )

    #delete the temp file
    File.delete(path)

    return

  end
end
