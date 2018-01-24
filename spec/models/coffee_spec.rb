# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Coffee do
  describe 'initialize' do
    context 'initializing with name' do
      subject { CoffeeApp::Coffee.new(name: 'coffee name') }

      it 'Creates a coffee with name' do
        expect(subject.name).to eq 'coffee name'
      end
    end
  end

  describe 'add_size' do
    context 'Add a coffee size' do
      subject { CoffeeApp::Coffee.new(name: 'coffee name').add_size(CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00)) }

      it 'has a size on it' do
        expect(subject.sizes).not_to be_empty
      end
    end
  end

  describe 'price?' do
    let(:coffee) do
      coffee = CoffeeApp::Coffee.new(name: 'latte')
      coffee.add_size(CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00))
    end

    context 'Get price from existing variant' do
      subject { coffee.price?(:small) }

      it ('Has 1.00 price') { expect(subject).to eql BigDecimal.new('1.00') }
    end

    context 'Get price from a nonexistent variant' do
      subject { coffee.price?(:large) }

      it ('Has 0.00 price') { expect(subject).to eql BigDecimal.new('0.00') }
    end
  end
end
