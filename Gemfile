source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
gem 'selectize-rails', '~> 0.12.6'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'sweetalert-rails', '~> 1.1', '>= 1.1.3'
gem 'carrierwave', '~> 1.3', '>= 1.3.1'
gem 'cloudinary', '~> 1.11', '>= 1.11.1'
gem 'chartkick', '~> 3.0', '>= 3.0.2'
# gem 'rails-alertify', '~> 0.3.2'
# gem 'alertifyjs-rails', '~> 1.11', '>= 1.11.2'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'jquery-validation-rails', '~> 1.19'
gem 'will_paginate', '~> 3.1', '>= 3.1.7'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'
gem 'momentjs-rails', '~> 2.20', '>= 2.20.1'
gem 'ckeditor', '~> 4.2'
gem 'TimeFeature', '~> 0.1.0'
gem 'adminlte2-rails', '~> 0.0.6'
gem 'nested_form'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

gem 'alertifyjs-rails', '~> 1.11'
gem 'jquery-datatables', '~> 1.10', '>= 1.10.15'
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'groupdate', '~> 4.1', '>= 4.1.2'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
