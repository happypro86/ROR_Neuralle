source 'https://rubygems.org'

ruby '2.4.4'

gem 'rails', '~> 4.2.8'
gem 'rake'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'puma'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-rails'
gem 'pg'
gem 'momentjs-rails'
gem 'rack-cors'
gem 'figaro'
gem 'haml-rails', '~> 0.9'
# We need carrierwave to make podcast files uploading work
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'carrierwave_backgrounder'
# We need fog-aws to make carrierwave work
gem 'fog-aws'
# Background processor to make carrierwave direct uploads work
gem 'sidekiq'
gem 'auto_strip_attributes', '~> 2.1'
gem 'social-share-button'
gem "lograge"
gem 'owlcarousel2-rails', '~> 2.2', '>= 2.2.1'
gem 'bootstrap-slider-rails'
gem "recaptcha", require: "recaptcha/rails"
gem 's3_direct_upload'
gem 'country_select'
gem 'sanitize'
gem 'stripe'
gem 'oauth2'
gem 'remotipart', '~> 1.2'
gem 'bitpay-sdk'
gem 'instagram_api_client'
gem 'rack-protection', '~> 1.5.5'
gem 'rack-attack'
gem 'nokogiri', '~> 1.10.10'
gem 'loofah', '~> 2.2.1'
gem 'sprockets', '~> 2.12.5'
# Wrapper for MailChimp's API
gem 'gibbon', '~> 2.2', '>= 2.2.3'
gem 'premailer'
gem 'premailer-rails'
gem 'twitter_bootstrap_wizard_rails'

group :production do
  gem 'dragonfly-s3_data_store'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'derailed'
  gem 'foreman'
  gem 'guard'
  gem 'guard-livereload'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'pry'
end

group :test do
  gem 'database_cleaner'
end

gem 'sdoc', '~> 0.4.0', group: :doc

# Refinery
gem 'refinerycms', '~> 3.0'

# Blog
gem 'refinerycms-blog', git: 'https://github.com/refinery/refinerycms-blog', branch: 'master'
gem 'rails-html-sanitizer', '~> 1.0.4'

# Add support for searching inside Refinery's admin interface.
gem 'refinerycms-acts-as-indexed', ['~> 2.0', '>= 2.0.0']

# Add support for Refinery's custom fork of the visual editor WYMeditor.
gem 'refinerycms-wymeditor', ['~> 1.0', '>= 1.1.0']
gem 'refinerycms-videojs', git: 'https://github.com/anitagraham/refinerycms-videojs.git'

# Authentication
gem 'refinerycms-authentication-devise', '~> 1.0.4'

gem 'refinerycms-footers', path: 'vendor/extensions'
gem 'refinerycms-service_options', path: 'vendor/extensions'

gem 'refinerycms-podcast', '~> 1.0', '>= 1.0.1'
