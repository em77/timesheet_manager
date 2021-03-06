source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '3.12.6'
gem 'rack-timeout'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '3.4.1'
gem 'bootstrap_form'
gem 'momentjs-rails', '>= 2.9.0'
gem 'moment_timezone-rails',
  git: 'https://github.com/viclim/moment_timezone-rails.git',
  ref: '35d001ea018ffca8b64fc62347734b716ce93d37'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.43'
gem 'holidays'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '5.0.5'
# Autocomplete
gem 'rails-jquery-autocomplete'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Authentication
gem 'sorcery', '~> 0.15'

# Authorization
gem 'pundit'

# For handling pay amounts
gem 'money-rails'

# Pagination
gem 'will_paginate', '~> 3.1.0'

# For next/previous record
gem 'order_query'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  # Fake data generator for testing
  gem 'faker'
  # Active Record model diagram generation
  gem 'rails-erd'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
