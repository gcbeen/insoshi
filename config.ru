# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
#run Insoshi::Application
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
