# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::NullCoffee do
  let(:null_coffee) { CoffeeApp::NullCoffee.new }

  describe '#initialize' do
    it 'creates with default name' do
      expect(null_coffee.name).to eq('Unknown')
    end

    it 'creates with custom name' do
      coffee = CoffeeApp::NullCoffee.new(name: 'Invalid Coffee')
      expect(coffee.name).to eq('Invalid Coffee')
    end
  end

  describe '#price' do
    it 'returns zero for any variant' do
      expect(null_coffee.price(:small).to_f).to eq(0.0)
      expect(null_coffee.price(:medium).to_f).to eq(0.0)
      expect(null_coffee.price(:large).to_f).to eq(0.0)
    end
  end

  describe '#add_size' do
    it 'returns self for method chaining' do
      variant = CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00)
      expect(null_coffee.add_size(variant)).to eq(null_coffee)
    end

    it 'does not actually store sizes' do
      variant = CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00)
      null_coffee.add_size(variant)
      expect(null_coffee.sizes).to be_empty
    end
  end

  describe '#sizes' do
    it 'returns empty array' do
      expect(null_coffee.sizes).to eq([])
    end
  end

  describe '#null_object?' do
    it 'returns true' do
      expect(null_coffee.null_object?).to be true
    end
  end
end
