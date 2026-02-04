# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.10'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '5.6.7'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Development & Test group
group :development, :test do
  # デバッグ用
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # RuboCop と Rails用拡張
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

# Development only
group :development do
  # Use console on exceptions pages
  gem 'web-console'

  # Add speed badges
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps
  # gem "spring"
end

# Test only
group :test do
  # Use system testing
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'devise'

gem 'rspec-rails', '~> 7.1', groups: %i[development test]

gem 'ffi'

# 権限管理
gem 'pundit'
