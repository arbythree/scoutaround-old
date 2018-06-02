ruby '2.4.2'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk-s3', '~> 1.2'
gem 'bootstrap', '~> 4.1.1'
gem 'bootstrap-datepicker-rails'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2'
gem 'combine_pdf'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mini_magick'
gem 'pdfjs_viewer-rails'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.2'
gem 'redcarpet'
gem 'sass-rails', '~> 5.0'
gem 'seedbank'
gem 'simple_form'
gem 'skylight'
gem 'slim'
# gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver'
  gem 'sqlite3'
end

group :development do
  gem 'awesome_print'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
end

group :test do
  # gem 'capybara-webkit'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
  gem 'launchy'
end
