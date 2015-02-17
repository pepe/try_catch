require 'roda'

# Main service module
module Service
  class API < Roda
    route do |r|
      r.get '' do
        response.status = 200
      end
    end
  end
end
