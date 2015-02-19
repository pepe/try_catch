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

        check_perm('admin', 'user')

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

        r.put do
          r.is ':id' do |id|
            position = Domain::Store.model(:position)[id]
            # FIXME: with in store logic
            if user.admin? || position.creator == user
              position.update_fields(r, ['living'])
              r.halt(200)
            else
              r.halt(401)
            end
          end
        end
      end
    end
  end
end
