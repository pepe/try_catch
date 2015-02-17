require_relative '../api_spec_helper'

RSpec.describe 'Service::Spec' do
  it 'exists' do
    expect(Service::API).to be_a Class
  end
end
