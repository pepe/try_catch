require 'sequel'
DB = Sequel.sqlite # memory database

DB.create_table :users do
  primary_key :id
  String :call_name
  String :password
  String :role
end

DB.create_table :trees do
  primary_key :id
  String :common_name
  String :latin_name
  String :positionable
end

require_relative 'domain/store'
require_relative 'domain/user'
require_relative 'domain/tree'
