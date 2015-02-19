require 'rack'

module BasicAuth
  # Instance methods, which got included in to Roda app
  module InstanceMethods
    ROLES = %w(guest user admin).freeze

    attr_reader :user
    def check_perm(*roles)
      roles.empty? && roles = ROLES
      return if authorized?(roles)
      response.headers['WWW-Authenticate'] = 'Basic realm="Trees sanctuary"'
      request.halt 401
    end

    def authorized?(roles)
      return unless auth_has_credentials?
      creds = @auth.credentials
      # FIXME: with specialized auth store vvv
      # Domain::Store.auth(creds, roles)
      user_store = Domain::Store.model(:user)
      @user = user_store.where(call_name: creds.first,
                               password: creds.last).first
      return unless @user
      roles.include?(@user.role)
    end

    private

    def auth
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    end

    def auth_has_credentials?
      auth.provided? && auth.basic? && auth.credentials
    end
  end
end
