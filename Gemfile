source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'

# gem "jbuilder"
# gem "redis", "~> 4.0"
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# gem "image_processing", "~> 1.2"
gem 'devise'
gem 'devise-jwt'
gem 'rack-cors'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.20'
  gem 'rspec-benchmark', '~> 0.6.0'
  gem 'rspec-rails', '~> 5.1'
end

group :development do
  # gem "spring"
  gem 'annotate', '~> 3.2'
  gem 'letter_opener', '~> 1.8'
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.1', require: false
  gem 'rubocop', '~> 1.27', require: false
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'simplecov', '~> 0.21.2', require: false
end

