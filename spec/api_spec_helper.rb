require 'rack/test'

require_relative '../service'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Service::API
end
