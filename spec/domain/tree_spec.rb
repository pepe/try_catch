require_relative '../../domain_helper'

RSpec.describe 'Domain::Tree' do
  it 'exists' do
    expect(Domain::Tree).to be_a Class
  end

  describe 'its values' do
    let(:tree) do
      Domain::Tree.new(common_name: 'birch',
                       latin_name: 'betula',
                       positionable: true)
    end

    it 'has common name' do
      expect(tree.common_name).to eq 'birch'
    end

    it 'has latin name' do
      expect(tree.latin_name).to eq 'betula'
    end

    it 'has positionable' do
      expect(tree.positionable).to be_truthy
    end
  end
end
