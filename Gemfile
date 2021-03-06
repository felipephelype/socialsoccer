source 'http://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use Postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'puma'
# para o deploy
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise', '~> 4.2.0'
# Use ActiveModel has_secure_password
gem 'rails_12factor'
# For AWS storage
gem 'fog'

# File upload gems
gem 'mini_magick'
gem 'carrierwave'
gem "figaro"

gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '=1.6.2'

  # Code quality
  gem 'rubocop', require: false

  # Automated tests in general
  gem "rspec-rails", "~> 3.4.2"

  # Mock rails models
  gem "factory_girl_rails", "~> 4.4.1"

  # Generate random data for factories
  gem "faker", "~> 1.6.3"

  # Used in rspec tests
  gem "rspec-its"

  # Make easier to test for associations
  gem 'shoulda'

  # Functional testing
  gem 'capybara'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :test do
  # Mock and stub methods
  gem 'webmock', '~> 1.21.0'

  # Show test coverage of the aplication
  gem "simplecov"
end
