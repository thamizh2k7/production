require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
require 'csv'
 
module RailsAdminFinalizeBook
end
 
module RailsAdmin
  module Config
    module Actions
      class FinalizeBook< RailsAdmin::Config::Actions::Base
      	RailsAdmin::Config::Actions.register(self)
      
#       	register_instance_option :member? do
# 					true
# 				end
				
				register_instance_option :link_icon do
					'icon-check'
				end
				
				# Should the action be visible
        register_instance_option :visible? do
          true
        end

        register_instance_option :authorized? do
          true
        end

        # Is the action on a model scope (Example: /admin/team/export)
        register_instance_option :collection? do
          true
        end
        
        register_instance_option :action_name do
          custom_key.to_sym
        end

        # I18n key
        register_instance_option :i18n_key do
          key
        end

        # User should override only custom_key (action name and route fragment change, allows for duplicate actions)
        register_instance_option :custom_key do
          key
        end
        
        # This block is evaluated in the context of the controller when action is called
        # You can access:
        # - @objects if you're on a model scope
        # - @abstract_model & @model_config if you're on a model or object scope
        # - @object if you're on an object scope
        register_instance_option :controller do
					Proc.new do
            if request.method == "GET"
            	render :action => @action.template_name
            else
              csvfile = params[:book_csv].read
              CSV.parse(csvfile) do |row|
                unless row[0].to_i.is_a? (Integer)
                  puts "not an integer"
                  next
                end
                book = Hash.new()
                book["name"] = row[1]
                book["author"] = row[2]
                book["isbn10"] =row[3]
                book["isbn13"] = row[4]
                book["binding"] = row[5]
                book["published"] = row[6]
                book["edition"] = row[8]
                book["pages"] = row[9]
                book["availability"]=row[14]
                book["price"]=row[15]
                book["description"]=row[16]
               # book["language"] = row[10]
                publisher = Publisher.where(:name=>row[7]).first
                if publisher.nil?
                  publisher=Publisher.create(:name=>row[7])
                end
                puts book
                book_save=Book.create(book)
                book_save.publisher=publisher
                if row[10] !=""
                  #book_save.images.create(:image_url=>row[13],:image_file_name=>"#{row[4]}.jpeg")
                  img=Image.create(:image_url=>row[13])
                  book_save.images << img
                end
                book_save.save
              end
              redirect_to "/admin/book"
            end
					end
				end
				
				
				# List of methods allowed. Note that you are responsible for correctly handling them in :controller block
        register_instance_option :http_methods do
          [:get, :post]
        end
      	
      end
    end
  end
end