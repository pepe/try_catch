require_relative '../domain'
require_relative 'api_spec_helper.rb'

RSpec.configure do |config|
  include Domain

  config.before(:all) do
    users = Store.model(:user)
    users.create(call_name: 'user', password: 'only', role: 'user')
    users.create(call_name: 'pepe', password: 'theonly', role: 'admin')
    trees = Store.model(:tree)
    { 'birch' => 'betula', 'oak' => 'quercus' }.each_pair do |common, latin|
      trees.create(common_name: common,
                   latin_name: latin,
                   positionable: true)
    end
  end

  config.after(:all) do
    Store.model(:user).each(&:delete)
    Store.model(:tree).each(&:delete)
  end
end

