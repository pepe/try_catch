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
      before do
        Domain::User.create(call_name: 'pepe', password: 'theonly', role: 'admin')
        authorize 'pepe', 'theonly'
      end

      it 'is succesfull' do
        get '/trees'
        expect(last_response.status).to eq 200
      end
    end
  end
end
