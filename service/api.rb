module Service
  # Main API class
  module API
    # API Root class
    class Root < Roda
      route do |r|
        # This route could be used as the ping endpoint
        r.root do
          response.status = 200
        end

        r.on 'trees' do
          r.run Tree
        end

        r.on 'positions' do
          r.run Position
        end
      end
    end
  end
end
