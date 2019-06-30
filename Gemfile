source "https://rubygems.org"

# gem "rails"
ruby '2.6.1'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem 'rack-flash3'


group :development, :test do
    gem 'sqlite3'
    gem 'shotgun'
    gem 'pry'
end

group :production do
    gem 'pg'
end
