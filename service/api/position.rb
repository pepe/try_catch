module Service
  module API
    # Position API class
    class Position < Roda
      plugin :halt
      plugin :json
      plugin :all_verbs

      plugin BasicAuth

      route do |r|
        check_perm

        r.get do
          r.is do
            Domain::Store.model(:position).all.map(&:values)
          end

          r.is ':id' do |id|
            Domain::Store.model(:position)[id].values
          end
        end

        r.post do
          r.is do
            Domain::Store.model(:position).create(
              longitude: r['longitude'],
              latitude: r['latitude'],
              living: true,
              creator_id: user.id,
              tree_id: r['tree_id'])
            r.halt(201)
          end
        end
      end
    end
  end
end
