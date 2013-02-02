source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'pg'

# Useful String extensions
gem 'stringex'

group :assets do
  gem 'bootstrap-sass'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'thin'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'

  group :darwin do
    gem 'rb-readline', require: false

  end
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'growl'
  gem 'simplecov', require: false
  gem 'rb-fsevent', :require => false
  gem 'simplecov-rcov', require: false
  gem 'ci_reporter', '>= 1.7.0', require: false
end