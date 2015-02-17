require_relative '../../domain_helper'

RSpec.describe 'Domain::Store' do
  it 'exists' do
    expect(Domain::Store).to be_a Module
  end

  it 'returns user store' do
    expect(Domain::Store.model(:user)).to be Domain::User
  end

  it 'returns tree store' do
    expect(Domain::Store.model(:tree)).to be Domain::Tree
  end
end
