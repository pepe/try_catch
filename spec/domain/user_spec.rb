require_relative '../../domain_helper'

RSpec.describe 'Domain::User' do
  it 'exists' do
    expect(Domain::User).to be_a Class
  end

  describe 'its values' do
    let(:user) do
      Domain::User.new(call_name: 'pepe', password: 'theonly', role: 'admin')
    end

    it 'has call name' do
      expect(user.call_name).to eq 'pepe'
    end

    it 'has pasword' do
      expect(user.password).to eq 'theonly'
    end

    it 'has role' do
      expect(user.role).to eq 'admin'
    end
  end
end
