require_relative '../../position_api_spec_helper'

RSpec.describe 'Service::API::Position' do
  it 'exists' do
    expect(Service::API::Tree).to be_a Class
  end

  it 'is protected' do
    get '/positions'
    expect(last_response.status).to eq 401
  end
end
