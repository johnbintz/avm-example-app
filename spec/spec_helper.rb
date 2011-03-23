require 'mocha'
require 'capybara/rspec'

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Capybara
end

