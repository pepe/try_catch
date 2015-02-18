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

        r.is do
          r.halt(200)
        end
      end
    end
  end
end

