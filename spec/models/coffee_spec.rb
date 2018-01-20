require 'spec_helper'

RSpec.describe Coffee do
  context 'initialize' do
    subject { Coffee.new(name: 'coffee name') }

    it 'Creates a coffee with name' do
      expect(subject.name).to eq 'coffee name'
    end
  end

  context 'Add a coffee size' do
    subject { Coffee.new(name: 'coffee name').add_size(CoffeeVariant.new({size: :small, price: 1.00})) }

    it 'has a size on it' do
      expect(subject.sizes).not_to be_empty
    end

  end
end