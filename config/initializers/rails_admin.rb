RailsAdmin.config do |config|

	config.current_user_method { current_user } # auto-generated

  config.main_app_name = ['Sociorent', 'Admin']

	config.authorize_with do
		redirect_to root_url unless current_user.is_admin?
	end

end