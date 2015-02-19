require_relative '../../position_api_spec_helper'

RSpec.describe 'Service::API::Position' do
  it 'exists' do
    expect(Service::API::Tree).to be_a Class
  end

  it 'is protected' do
    get '/positions'
    expect(last_response.status).to eq 401
  end

  describe 'authenticated with role user' do
    before do
      authorize 'user', 'only'
    end

    it 'is succesfull' do
      get '/positions'
      expect(last_response.status).to eq 200
    end

    it 'returns all positions' do
      get '/positions'
      expect(last_response.body).to eq(
        "[{\"id\":1,\"longitude\":40.0,\"latitude\":50.0,\"living\":true,\
\"tree_id\":1,\"creator_id\":1},{\"id\":2,\"longitude\":50.0,\"latitude\":60.0,\
\"living\":true,\"tree_id\":2,\"creator_id\":2}]")
    end

    it 'returns one position' do
      get '/positions/1'
      expect(last_response.body).to eq(
        "{\"id\":1,\"longitude\":40.0,\"latitude\":50.0,\"living\":true,\
\"tree_id\":1,\"creator_id\":1}")
    end

    describe 'changing' do
      it 'can create new position' do
        post '/positions', longitude: 40, latitude: 40, living: true, tree_id: 1
        expect(last_response.status).to eq 201
      end

      it 'cannot change admins position' do
        pending 'Put'
        put '/position/1', living: false
        expect(last_response.status).to eq 401
      end

      after do
        position = Domain::Store.model(:position)[3]
        position && position.destroy
      end
    end
  end
end
