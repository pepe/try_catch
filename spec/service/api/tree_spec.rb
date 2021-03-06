require_relative '../../tree_api_spec_helper'

RSpec.describe 'Service::API::Tree' do
  it 'exists' do
    expect(Service::API::Tree).to be_a Class
  end

  it 'is protected' do
    get '/trees'
    expect(last_response.status).to eq 401
  end

  describe 'authenticated with role user' do
    before do
      authorize 'user', 'only'
    end

    it 'is succesfull' do
      get '/trees'
      expect(last_response.status).to eq 200
    end

    it 'returns all trees' do
      get '/trees'
      expect(last_response.body).to eq(
        "[{\"id\":1,\"common_name\":\"birch\",\"latin_name\":\"betula\",\
\"positionable\":\"true\"},{\"id\":2,\"common_name\":\"oak\",\
\"latin_name\":\"quercus\",\"positionable\":\"true\"}]")
    end

    it 'returns one tree' do
      get '/trees/1'
      expect(last_response.body).to eq(
        "{\"id\":1,\"common_name\":\"birch\",\"latin_name\":\"betula\",\
\"positionable\":\"true\"}")
    end

    it 'cannot change tree' do
      put '/trees'
      expect(last_response.status).to eq 401
    end
  end

  describe 'authenticated with role admin' do
    describe 'creating' do
      before do
        authorize 'pepe', 'theonly'
        post '/trees', common_name: 'beech',
                       latin_name: 'fagus',
                       positionable: true
      end

      it 'can create tree' do
        expect(last_response.status).to eq 201
      end

      it 'lists created tree' do
        # FIXME: with location header and getting just one
        get '/trees'
        expect(last_response.body).to eq(
          "[{\"id\":1,\"common_name\":\"birch\",\"latin_name\":\"betula\",\
\"positionable\":\"true\"},{\"id\":2,\"common_name\":\"oak\",\
\"latin_name\":\"quercus\",\"positionable\":\"true\"},\
{\"id\":3,\"common_name\":\"beech\",\"latin_name\":\"fagus\",\
\"positionable\":\"true\"}]")
      end

      after do
        Domain::Store.model(:tree).last.destroy
      end
    end

    describe 'changing' do
      before do
        authorize 'pepe', 'theonly'
        put '/trees/1', positionable: false
      end

      it 'is succesfull' do
        expect(last_response.status).to eq 200
      end

      it 'changes the tree' do
        get '/trees/1'
        expect(last_response.body).to eq(
          "{\"id\":1,\"common_name\":\"birch\",\"latin_name\":\"betula\",\
\"positionable\":\"false\"}")
      end

      after do
        Domain::Store.model(:tree)[1].update(positionable: true)
      end
    end
  end

  describe 'false credentials' do
    before do
      authorize 'bad', 'boy'
    end

    it 'is protected' do
      get '/trees'
      expect(last_response.status).to eq 401
    end
  end
end
