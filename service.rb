require 'roda'
require_relative 'lib/basic_auth'

# Main service module
module Service
  # Main API class
  class API < Roda
    plugin :halt
    plugin :json
    plugin :all_verbs
    plugin BasicAuth

    route do |r|
      # This route could be used as the ping endpoint
      r.root do
        response.status = 200
      end

      r.on 'trees' do
        check_perm

        r.get do
          r.is do
            Domain::Store.model(:tree).all.map(&:values)
          end

          r.is ':id' do |id|
            Domain::Store.model(:tree).find(id).values
          end
        end

        r.post do
          check_perm('admin')

          r.is do
            Domain::Store.model(:tree).create(common_name: r['common_name'],
                                              latin_name: r['latin_name'],
                                              positionable: r['positionable'])
            r.halt(201)
          end
        end

        r.put do
          check_perm('admin')

          r.is ':id' do |id|
            tree = Domain::Store.model(:tree).find(id)
            tree.update_fields(r, ['positionable'])
            r.halt(200)
          end
        end
      end
    end
  end
end
