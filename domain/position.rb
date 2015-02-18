module Domain
  class Position < Sequel::Model
    many_to_one :creator, class: Domain::User
    many_to_one :tree, class: Domain::Tree
  end
end
