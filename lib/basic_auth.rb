require 'rack'

module BasicAuth
  # Instance methods, which got included in to Roda app
  module InstanceMethods
    def check_perm
      return if authorized?
      response.headers['WWW-Authenticate'] = 'Basic realm="Trees sanctuary"'
      request.halt 401
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      return unless @auth.provided? && @auth.basic? && @auth.credentials
      creds = @auth.credentials
      user_store = Domain::Store.model(:user)
      user_store.where(call_name: creds.first, password: creds.last).first
    end
  end
end
