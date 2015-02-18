require_relative 'tree_api_spec_helper.rb'

RSpec.configure do |config|
  include Domain

  config.before(:all) do
    [[40.0, 50.0 , 1, 1], [50.0, 60.0, 2, 2]].each do |attrs|
      Domain::Position.new(longitude: attrs[0],
                           latitude: attrs[1],
                           living: true,
                           creator_id: attrs[2],
                           tree_id: attrs[3])
    end
  end

  config.after(:all) do
    Store.model(:position).each(&:delete)
  end
end
