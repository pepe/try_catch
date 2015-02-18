ENV['RACK_ENV'] = 'test'
require 'rack/test'

require_relative '../service'
require_relative '../domain'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Service::API::Root
end
