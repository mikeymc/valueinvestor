# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'webmock/rspec'
require 'capybara/rspec'
require 'capybara/rails'
require 'rspec/rails'
require 'factory_girl_rails'
require 'selenium-webdriver'
require 'database_cleaner'

ActiveRecord::Migration.check_pending!
WebMock.allow_net_connect!

Capybara.configure do |configuration|
  configuration.run_server = true
  configuration.server_port = 8888
  configuration.default_driver = :selenium_chrome_headless
  configuration.app_host = 'http://localhost:8888'
  configuration.default_max_wait_time = 10
end

RSpec.configure do |configuration|
  configuration.include Capybara::DSL
  configuration.include FactoryGirl::Syntax::Methods
  configuration.infer_spec_type_from_file_location!

  DatabaseCleaner.strategy = :truncation
  configuration.before(:each) { DatabaseCleaner.start }
  configuration.after(:each) { DatabaseCleaner.clean }
end
