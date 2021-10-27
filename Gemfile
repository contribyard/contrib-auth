source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in contrib-auth.gemspec.
gemspec

gem 'sqlite3'

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
end

group :test do
  gem 'webmock', '3.14.0'
  gem 'sinatra'
end
