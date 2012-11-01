require Rails.root.join('lib','rails_admin_rented.rb')

RailsAdmin.config do |config|

  config.current_user_method { current_user } # auto-generated

  config.main_app_name = ['Sociorent', 'Admin']

	config.authorize_with do
		redirect_to "/home/index" unless current_user.is_admin?
	end

	config.excluded_models = ["BookCart", "BookOrder"]

	config.actions do
		# root actions
    dashboard
    # collection actions 
    index
    new do
			visible do
				["General"].exclude?bindings[:abstract_model].model.to_s
			end
		end
    export
    history_index
    rented do
      visible do
        bindings[:abstract_model].model.to_s == "Book"
      end
    end
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
	end

  config.model User do
    edit do
      field :email 
      field :password
      field :name
      field :is_admin
    end
    create do
      field :email 
      field :password
      field :name
      field :is_admin
    end
    show do
      include_all_fields
      field :ambassador do
        label "Referrer"
      end
    end
  end
end