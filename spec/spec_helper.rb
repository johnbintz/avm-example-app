require 'mocha'
require 'capybara/rspec'
require 'capybara/zombie'

Capybara.default_driver = :zombie

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Capybara
end

