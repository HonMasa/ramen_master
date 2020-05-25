# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'actionview'
gem 'bootsnap', '1.4.4', require: false
gem 'bootstrap'
gem 'carrierwave'
gem 'counter_culture'
gem 'devise'
gem 'jbuilder', '2.9.1'
gem 'jquery-rails'
gem 'puma', '3.12.4'
gem 'rails', '6.0.0'
gem 'rails-i18n'
gem 'sass-rails', '5.1.0'
gem 'shoulda-matchers'
gem 'turbolinks', '5.2.0'
gem 'uglifier'
gem 'webpacker', '4.0.7'
gem 'kaminari'

group :development, :test do
  gem 'byebug', '11.0.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'forgery_ja'
  gem 'rspec-rails', '4.0.1'
  gem 'sqlite3', '1.4.1'
end

group :development do
  gem 'listen', '3.1.5'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'spring', '2.1.0'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console', '4.0.1'
end

group :test do
  gem 'capybara', '3.28.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'launchy', '~> 2.3.0'
  gem 'selenium-webdriver', '3.142.4'
  gem 'webdrivers',         '4.1.2'
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
