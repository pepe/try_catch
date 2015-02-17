require 'rack'

module BasicAuth
  module InstanceMethods
    def check_perm
      return if authorized?
      response.headers['WWW-Authenticate'] = 'Basic realm="Trees sanctuary"'
      request.halt 401
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      if @auth.provided? && @auth.basic? && creds = @auth.credentials
        user_store = Domain::Store.model(:user)
        user_store.where(call_name: creds.first, password: creds.last)
      end
    end
  end
end
