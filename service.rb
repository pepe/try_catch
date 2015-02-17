require 'roda'
require_relative 'lib/basic_auth'

# Main service module
module Service
  # Main API class
  class API < Roda
    plugin :halt
    plugin :json
    plugin BasicAuth

    route do |r|
      # This route could be used as the ping endpoint
      r.root do
        response.status = 200
      end

      r.on 'trees' do
        check_perm

        r.get do
          Domain::Store.model(:tree).all.map(&:values)
        end
      end
    end
  end
end
