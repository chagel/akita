source 'https://rubygems.org'
#source 'http://ruby.taobao.org'

gem 'rails', '3.2.14'

group :assets do
  gem 'sass', '>= 3.2.7'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem 'zurb-foundation', '>= 3.2.2'
  gem "select2-rails"
  gem 'therubyracer', :platforms => :ruby
end

gem 'jquery-rails'

gem "devise"
gem "mongoid", ">= 3.0.3"
gem "mongoid_rails_migrations", ">= 1.0.0"
gem "omniauth", ">= 1.1.0"
gem "omniauth-google-oauth2"
gem 'kaminari'
gem 'slim'
gem 'nokogiri'
gem 'rails_admin'
gem 'exception_notification'
gem 'social-share-button'

group :development do
  gem 'thin'
  gem 'quiet_assets'
  gem "guard-rspec"
  gem "spork"
  gem "guard-spork"
  gem 'rb-fsevent'
  gem "terminal-notifier-guard"
  # gem 'rails-dev-tweaks', '~> 0.6.1'
end

group :test do 
	gem "capybara", ">= 1.1.2"
	gem "database_cleaner", ">= 0.8.0"
	gem "mongoid-rspec", ">= 1.4.6"
	gem "cucumber-rails", ">= 1.3.0"
	gem "launchy", ">= 2.1.2"
end 

group :development, :test do 
	gem "rspec-rails", ">= 2.11.0"
	gem "factory_girl_rails", ">= 4.0.0"
end 
