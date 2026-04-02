source "https://rubygems.org"

gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "rails-i18n", "~> 7.0"
gem "tzinfo-data", platforms: %i[windows jruby]

gem "puma", ">= 5.0"
gem "sprockets-rails"


gem "slim-rails", "~> 4.0"

group :development, :test do
  gem "dotenv-rails", "~> 3.2"
  gem "byebug"
  gem "rspec-rails", "~> 8.0"
end

group :development do
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "webmock"
end
