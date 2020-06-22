source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'annotate'
gem 'attribute_normalizer'
gem 'auth_client', git: 'https://github.com/openteam-tusur/auth_client'
gem 'auth_redis_user_connector', git: 'https://github.com/openteam-tusur/auth_redis_user_connector'
gem 'awesome_print'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap'
gem 'cancancan'
gem 'caxlsx'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'kaminari'
gem 'non-stupid-digest-assets'
gem 'openteam-commons', '~> 0.3.3.6'
gem 'paper_trail'
gem 'petrovich', '~> 1.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2'
gem 'redis-session-store'
gem 'russian'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'simple-navigation'
gem 'simple_form'
gem 'sprockets-rails', '>= 2.3.2'
gem 'stop_ie'
gem 'turbolinks', '~> 5'
gem 'tusur_header', '~> 0.2.14'
gem 'webpacker', '~> 3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails'
end

group :development do
  gem 'capistrano-auth-subscriber'
  gem 'capistrano-db-tasks', '0.6', require: false
  gem 'capistrano-yarn'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'openteam-capistrano', '~> 1.0.15'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
