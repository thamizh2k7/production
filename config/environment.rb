# Load the rails application
require File.expand_path('../application', __FILE__)

Sociorent::Application.configure do
	config.gem(
	  'thinking-sphinx',
	  :lib     => 'thinking_sphinx',
	  :version => '1.4.10'
	)

	config.gem 'active_merchant_ccavenue'
end

# Initialize the rails application
Sociorent::Application.initialize!