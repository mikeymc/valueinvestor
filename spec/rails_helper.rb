# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'rspec/rails'
require 'factory_girl'
require 'selenium-webdriver'

WebMock.allow_net_connect!

ActiveRecord::Migration.check_pending!
FactoryGirl.find_definitions

Capybara.configure do |configuration|
  configuration.run_server = true
  configuration.server_port = 8888
  configuration.default_driver = :selenium
  configuration.app_host = 'http://localhost:8888'
  configuration.default_max_wait_time = 10
end

RSpec.configure do |configuration|
  configuration.include Capybara::DSL
  configuration.include FactoryGirl::Syntax::Methods
  configuration.use_transactional_fixtures = true
  configuration.infer_spec_type_from_file_location!
end
