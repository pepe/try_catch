module Domain
  # Model representing the user in the system
  class User < Sequel::Model
    def admin?
      role == 'admin'
    end
  end
end
