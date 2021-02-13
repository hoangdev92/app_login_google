source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#############################
# CORE
#############################
ruby '2.7.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'puma', '~> 4.1'
gem 'mysql2', '>= 0.4.4'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'redis'
gem 'hiredis'
gem 'sidekiq'

#############################
# ENGINE
#############################
gem 'ransack'
gem 'pagy'
gem 'signet'
gem 'httparty'
gem 'google-api-client'

#############################
# API
#############################
gem 'bcrypt', '~> 3.1.7'
gem 'rack-cors'
gem 'jwt'
gem 'jb'

#############################
# DEVELOPMENT
#############################
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'pry-byebug', '~> 3.9'
  gem 'rubocop', require: false
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
