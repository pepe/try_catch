require_relative 'service'
require_relative 'domain'
require_relative 'seed'

run Service::API::Root.freeze
