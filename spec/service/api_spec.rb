require_relative '../api_spec_helper'

RSpec.describe 'Service::API' do
  it 'exists' do
    expect(Service::API).to be_a Class
  end

  it 'has root' do
    get '/'
    expect(last_response.status).to eq 200
  end
end
