class P2p::MessagesController < ApplicationController
	layout :p2p_layout
  def index
  	
     @user=P2p::User.find(current_user.id)
     @message=@user.sent_messages.new
   
  	#Inbox => Both read and unread messages from scope
	  @inbox = @user.received_messages.inbox
    @inbox_admin_msg = @user.received_messages.inbox.where("messagetype=2")
    @inbox_sell_req = @user.received_messages.inbox.where("messagetype=1") 
    @inbox_buy_req = @user.received_messages.inbox.where("messagetype=0") 
  
	  # getting the sent messages from the scope
	  @sent = @user.sent_messages.sent 
  #@mesage=P2p::Message.all
  #@inbox=P2p::Message.inbox

  end

  def create
  	 @user=P2p::User.find(current_user.id)
     
  	 @message=@user.sent_messages.create(params[:message])
     @message.update_attributes(:sender_status=>"sent")
      flash[:notice] = "Message sent Successfully"
      redirect_to "p2p/messages/"
    end
        
 
  def show
    @message=P2p::Message.find(params[:id])
    @message.update_attributes(:flag=>"read") if @message.flag != "read"
     respond_to do |format|
      format.js
      format.html
     end

  end  

  def destroy
  end

  def new
    @mesage=P2p::Message.new

    if request.xhr? 
      render "messages/compose"
    else
      
    end

  end


end
