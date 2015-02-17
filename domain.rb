require 'sequel'
DB = Sequel.sqlite # memory database

DB.create_table :users do
  primary_key :id
  String :call_name
  String :password
  String :role
end
require_relative 'domain/store'
require_relative 'domain/user'
