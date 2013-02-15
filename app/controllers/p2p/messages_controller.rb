class P2p::MessagesController < ApplicationController
	layout :p2p_layout

  before_filter :p2p_user_signed_in 

  #check for user presence inside p2p
  before_filter :check_p2p_user_presence

  def index
  	
      @user=p2p_current_user
      @message = @user.sent_messages.new

     # puts @message.inspect + "message"
   
  	#Inbox => Both read and unread messages from scope
	   @inbox = @user.received_messages.inbox
  #   @inbox_admin_msg = @user.received_messages.inbox.where("messagetype=2")
  #   @inbox_sell_req = @user.received_messages.inbox.where("messagetype=1") 
  #   @inbox_buy_req = @user.received_messages.inbox.where("messagetype=0") 
  
	 #  # getting the sent messages from the scope
	 #  @sent = @user.sent_messages.sentbox
  # #@mesage=P2p::Message.all
  # #@inbox=P2p::Message.inbox

  end

  def create
  	 user=p2p_current_user

      # if params[:p2p_message][:item_id] != "" 
      #   item= P2p::Item.find(params[:p2p_message][:item_id])
      #   item.reqCount += 1
        
      # end
      params[:p2p_message][:receiver_status] = 0
      params[:p2p_message][:sender_status] = 2

      # //remove from from the params to pass to create message
      from = params[:p2p_message][:from]

      params[:p2p_message].delete(:from)
      
  	 @message=user.sent_messages.create(params[:p2p_message])

     unless @message.item.nil?
      @message.item.reqCount +=1
      @message.item.save
     end

      

      if request.xhr?
        if from
          render :js => "showNotifications('Your request was sent'); return false;"
        end

      else
        flash[:notice] = "Message sent Successfully"
        redirect_to "/p2p/messages/"
      end
      
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
    
    deleted_messages = []

    params[:msgid].each do |id|

        if params[:tbl] == 'inbox' 
          if p2p_current_user.received_messages.inbox.find(id).update_attributes(:receiver_status => 3 ) 
            deleted_messages.push(id)
          end
        elsif params[:tbl] == 'sentbox' 
          if p2p_current_user.sent_messages.sentbox.find(id).update_attributes(:sender_status => 3 ) 
            deleted_messages.push(id)
          end
        elsif params[:tbl] == 'deletebox' 
            msg = P2p::Message.deleted(p2p_current_user).find(id)

            if msg.sender == p2p_current_user.id
                msg.update_attributes(:sender_status => 4 ) 
            else
                msg.update_attributes(:receiver_status => 4 ) 
            end

            deleted_messages.push(id)
        end
    end

    unreadcount =  p2p_current_user.received_messages.inbox.unread.count 

    render :json => {:id =>  deleted_messages , :unreadcount => unreadcount}


  end

  def new
    @mesage=P2p::Message.new

    if request.xhr? 
      render "messages/compose"
    else
      
    end

  end

  def getmessages

    response={:aaData => []}

    if params.has_key?("iDisplayStart")
      start = (params[:iDisplayStart].to_i / 10) + 1
    else
      start = 1
    end

    search = ""
    if params.has_key?(:searchq)
      search = params[:searchq]
    end

    if params[:id] == 'inbox' 

      if search != ""
        messages = p2p_current_user.received_messages.inbox.order("created_at desc").where("message like '%#{search}%'").paginate( :page => start ,:per_page => 10)
        message_count = p2p_current_user.received_messages.inbox.where("message like '%#{search}%'").count
      else
        messages = p2p_current_user.received_messages.inbox.order("created_at desc").paginate( :page => start ,:per_page => 10)
        message_count = p2p_current_user.received_messages.inbox.count
      end


    elsif params[:id] == 'sentbox' 
      if search != ''
        messages = p2p_current_user.sent_messages.sentbox.order("created_at desc").where("message like '%#{search}%'").paginate( :page => start,:per_page => 10)
        message_count = p2p_current_user.sent_messages.sentbox.where("message like '%#{search}%'").count
        
      else
        messages = p2p_current_user.sent_messages.sentbox.order("created_at desc").paginate( :page => start,:per_page => 10)
        message_count = p2p_current_user.sent_messages.sentbox.count
      end
      
    elsif params[:id] == 'deletebox' 
      if search !=''
        messages = P2p::Message.deleted(p2p_current_user).order("created_at desc").where("message like '%#{search}%'").paginate( :page => start,:per_page => 10)
        message_count = P2p::Message.deleted(p2p_current_user).where("message like '%#{search}%'").count
      else
        messages = P2p::Message.deleted(p2p_current_user).order("created_at desc").paginate( :page => start,:per_page => 10)
      end
      
    end
#   

    response[:iTotalRecords] =  message_count
    response[:iTotalDisplayRecords] = message_count
    #response[:iStart] =  (params.has_key("iStart") ? (params[:iStart].to_i + 10) : 0 


    messages.each do |msg|

      tme =Time.now - msg.created_at

      if tme >= 86400
        tme =  (tme/86400).to_i.to_s + " days ago"
      elsif tme >=3600
        tme =  (tme/3600).to_i.to_s + " hr ago"
      else
        tme = (tme/60).to_i.to_s + "min ago"
      end
  
      

      response[:aaData].push(["<input type='checkbox' class='msg_check' msgid=\"#{msg.id}\" >",
                          msg.id,
                          msg.messagetype,
                          msg.sender.user.name,
                          "<div class='showmessage' msgid='#{msg.id}' ><a href='#' >#{msg.message.slice(0,15) + '...'}</a></div>",
                          tme,
                          
                          ])
    end 

    render :json => response

 end

end

