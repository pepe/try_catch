require 'roda'
require_relative 'lib/basic_auth'

# Main service module
module Service
  class API < Roda
    plugin :halt
    plugin BasicAuth

    route do |r|
      # This route could be used as the ping endpoint
      r.root do
        response.status = 200
      end

      r.on 'trees' do
        check_perm

        r.get do
          response.status = 200
        end
      end
    end
  end
end
