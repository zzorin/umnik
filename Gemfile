source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'annotate'
gem 'attribute_normalizer'
gem 'awesome_print'
gem 'bootstrap'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'sprockets-rails', '>= 2.3.2'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'tusur_header', '~> 0.2.14'
gem 'simple-navigation'
gem 'cancancan'
gem 'stop_ie'
gem 'jquery-rails'
gem 'openteam-commons', '~> 0.3.3.6'
gem 'auth_client', git: 'https://github.com/openteam-tusur/auth_client'
gem 'auth_redis_user_connector', git: 'https://github.com/openteam-tusur/auth_redis_user_connector'
gem 'redis-session-store'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
