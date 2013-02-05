class P2p::MessagesController < ApplicationController
	layout :p2p_layout
  def index
  	
     @user=P2p::User.find(current_user.id)
     @message=@user.sent_messages.new
   
  	#Inbox => Both read and unread messages from scope
	  @inbox = @user.received_messages.inbox 
  
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
     respond_to do |format|
      format.js
      format.html
     end

  end  

  def destroy
  end

  def new
    @mesage=P2p::Message.all
  end


end
