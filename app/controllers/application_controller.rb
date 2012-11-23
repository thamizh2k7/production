class ApplicationController < ActionController::Base
  protect_from_forgery
  def send_sms (receipient,msg)
    user_pwd="Sathish@sociorent.com:Sathish1"
    sender_id="TEST SMS"
    url= "http://api.mVaayoo.com/mvaayooapi/MessageCompose?user=#{user_pwd}&senderID=#{sender_id}&receipientno=#{receipient}&dcs=0&msgtxt=#{msg}&state=4"
    agent =Mechanize.new
    page = agent.get(url)
  end
end
