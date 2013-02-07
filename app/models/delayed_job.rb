class DelayedJob
	def send_sms(receipient,msg)
    user_pwd="Sathish@sociorent.com:Sathish1"
    sender_id="SOCRNT"
    url= "http://api.mVaayoo.com/mvaayooapi/MessageCompose?user=#{user_pwd}&senderID=#{sender_id}&receipientno=#{receipient}&dcs=0&msgtxt=#{msg}&state=4"
    agent =Mechanize.new
    page = agent.get(url)
    puts page.body
  end

  def order(user_id, order_id, bank_sms_text)
  	general = General.first
  	user = User.find(user_id)
  	order = user.orders.find(order_id)
  	books = order.books
  	# facebooks actions for order
  	if ENV["RAILS_ENV"] == "production"
	    # koala publish actions 
	    unless user.token.nil?
	    	token = user.token
	    	graph  = Koala::Facebook::API.new(token)
	    	books.each do |book|
		    	book_url = "http://www.sociorent.com/book/details/#{book.id}"
		    	graph.put_connections("me", "sociorent:rented", :book => book_url)
		    end
	    end
	  end

	  # sms
		if order.order_type == "bank"
    	send_sms(user.mobile_number,bank_sms_text)
    else 
    	send_sms(user.mobile_number,"Your order #{order.random} has been successfully received and will be processed. Please visit Sociorent.com to track the status of the order. Thank you.")
    end

    # mail 
		UserMailer.order_email(user, order).deliver
		
    # gharpay
   end

	handle_asynchronously :order, :run_at => Proc.new { 5.minutes.from_now }
end