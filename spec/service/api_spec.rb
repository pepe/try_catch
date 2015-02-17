require_relative '../api_spec_helper'

RSpec.describe 'Service::API' do
  it 'exists' do
    expect(Service::API).to be_a Class
  end

  it 'has root' do
    get '/'
    expect(last_response.status).to eq 200
  end

  describe 'trees path' do
    it 'is protected' do
      get '/trees'
      expect(last_response.status).to eq 401
    end

    describe 'authenticated' do
      before :all do
        users = Domain::Store.model(:user)
        users.create(call_name: 'pepe', password: 'theonly', role: 'admin')
        trees = Domain::Store.model(:tree)
        { 'birch' => 'betula', 'oak' => 'quercus' }.each_pair do |common, latin|
          trees.create(common_name: common,
                       latin_name: latin,
                       positionable: true)
        end
      end

      before do
        authorize 'pepe', 'theonly'
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
end
