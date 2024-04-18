source "https://rubygems.org"

# Ruby version
ruby "3.2.2"

gem "sinatra"
gem "activerecord"
gem "sinatra-activerecord"
gem "sinatra-contrib"
gem "thin"
gem "rake"
gem "faraday"
gem "json"
gem "dotenv"
gem "byebug"

group :development do
  gem "sqlite3", "~> 1.4"
  gem "tux" # gives you access to an interactive console similar to 'rails console'
  gem "dotenv"
end

group :production do
  gem "pg"
end
