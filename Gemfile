source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "rails-i18n", "~> 8.1"
gem "tzinfo-data", platforms: %i[windows jruby]

gem "puma", ">= 5.0"
gem "sprockets-rails"


gem "slim-rails", "~> 4.0"

group :development, :test do
  gem "dotenv-rails", "~> 3.2"
  gem "byebug"
  gem "rspec-rails", "~> 6.1"
end

group :development do
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "webmock"
end
