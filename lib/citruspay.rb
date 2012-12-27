module Citruspay
  class Base
    include HTTParty
    require 'digest/sha1'
  
    format :json
    #if Rails.env == 'production'
    #   base_uri "http://webservices.gharpay.in/rest/GharpayService"
    # else
      base_uri "https://sandboxadmin.citruspay.com/api/v2/txn"
    # end

    def initialize(access_key)
      @access_key=access_key
      @creds ={ 'access_key'=> @access_key, 'Content-Type' => 'application/json','Accept'=>'application/json' } 
    end
    
    # Creates a transaction for the citrus pay
    # parameter : txn -> hash of key-value pair
    # sample parameter txn
      # {'merchantTxnId'=>  't12345t21',
      # 'amount' =>  '1.0',
      # 'firstName'=>  'Test',
      # 'lastName' => 'Test',
      # 'address'=> 'Test',
      # 'addressCity'=>  'Pune',
      # 'addressState' => 'Goa',
      # 'addressZip' =>  '123456',
      # 'email' =>  'test@test.com',
      # 'mobile' => '1234567890',
      # 'paymentMode'=>  'NET_BANKING',
      # 'issuerCode' =>  'CID009',
      # 'returnUrl' =>  'http://localhost:3000/check_citrus'}

    def create_transaction(txn)
      options = {:body => txn.to_json(), :headers => @creds}
      res = self.class.post("/create", options)
      puts options
      return_val=res
      # if res['createOrderResponse']['orderID']
      #   return_val["status"]=true
      #   return_val["orderID"]=res['createOrderResponse']['orderID']
      # else
      #   return_val["status"]=false
      #   return_val["error"]=res['createOrderResponse']['errorMessage']
      # end
      puts res
      return return_val
    rescue
      return nil 
    end    
  
    # initiates the refund transaction.
    # parameter :txn_ary
    # sample parameter txn_ary
    # {
    #   "merchantTxnId"=>"62194401",
    #   "pgTxnId"=>"201009120014355",
    #   "rrn"=>"14000000000000001747",
    #   "authIdCode"=>"001832",
    #   "currencyCode"=>"INR",
    #   "txnType"=>"R",
    #   "amount"=>"1.0"
    # }

    def refund_transaction(txn_ary)
      hmac_sign="merchantAccessKey=#{@access_key}&transactionId=#{txn_ary['merchantTxnId']}&amount=#{txn_ary['amount']}"
      signature=  HMAC::SHA1.new(hmac_sign)
      options = {:body => txn_ary.to_json(), :headers => @creds.merge('signature' => signature )}
      res = self.class.post("/refund", options)
      return res
    rescue
      return false
    end

    # Get the status of the transrequire Rails.root.join('lib','Gharpay.rb')
    # parameter : txn_id -> Transaction id
    def transaction_enquiry(txn_id)
      options = {:headers => @creds}
      res = self.class.get("/enquiry/#{txn_id}", options)
      return res
    rescue
      return false
    end 

    # Search the transactions with in specified dates
    # parameters : params 
    #   {
    #   "txnStartDate"=>"20120710",
    #   "txnEndDate"=>"20120716"
    #   }
    def search_transactions(params)
      options = {:body => params.to_json(), :headers => @creds}
      res = self.class.post("/refund", options)
      return res
    rescue
      return false
    end
  end
end