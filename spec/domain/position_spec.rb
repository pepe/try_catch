require_relative '../../domain_helper'

RSpec.describe 'Domain::Tree' do
  it 'exists' do
    expect(Domain::Position).to be_a Class
  end

  describe 'its values' do
    let(:position) do
      Domain::Position.new(longitude: 47.5,
                           latitude: 50.0,
                           living: true)
    end

    it 'has longitude' do
      expect(position.longitude).to eq 47.5
    end

    it 'has latitude' do
      expect(position.latitude).to eq 50.0
    end

    it 'is living' do
      expect(position.living).to be_truthy
    end
  end

  describe 'its relations' do
    before do
      users = Domain::Store.model(:user)
      users.create(call_name: 'user', password: 'only', role: 'user')
      trees = Domain::Store.model(:tree)
      { 'birch' => 'betula', 'oak' => 'quercus' }.each_pair do |common, latin|
        trees.create(common_name: common,
                     latin_name: latin,
                     positionable: true)
      end
    end

    let(:position) do
      Domain::Position.new(longitude: 47.5,
                           latitude: 50.0,
                           living: true,
                           creator_id: 1,
                           tree_id: 1)
    end

    it 'has creator' do
      expect(position.creator).to be_a Domain::User
    end

    it 'has tree' do
      expect(position.tree).to be_a Domain::Tree
    end
  end
end
