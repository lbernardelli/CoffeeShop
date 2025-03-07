# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::OrderItem do
  describe 'price' do
    context 'Find a product price' do
      subject do
        coffee_variant = CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00)
        coffee = CoffeeApp::Coffee.new(name: 'coffee name').add_size(coffee_variant)

        CoffeeApp::OrderItem.new(variant: :small, product: coffee).price
      end

      it('Has the variant price') { expect(subject.to_f).to eq(1.00) }
    end

    context 'Find a product price from inconsistent order item' do
      subject do
        coffee_variant = CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00)
        coffee = CoffeeApp::Coffee.new(name: 'coffee name').add_size(coffee_variant)

        CoffeeApp::OrderItem.new(variant: :large, product: coffee).price
      end

      it('The price is 0.00') { expect(subject.to_f).to eq(0.0) }
    end
  end

  describe '#initialize validations' do
    let(:coffee_variant) { CoffeeApp::CoffeeVariant.new(size: :small, price: 1.00) }
    let(:coffee) { CoffeeApp::Coffee.new(name: 'coffee name').add_size(coffee_variant) }

    context 'with valid product and variant' do
      it 'creates order item successfully' do
        item = CoffeeApp::OrderItem.new(product: coffee, variant: :small)
        expect(item.product).to eq(coffee)
        expect(item.variant).to eq(:small)
      end
    end

    context 'with nil product' do
      it 'raises ValidationError' do
        expect { CoffeeApp::OrderItem.new(product: nil, variant: :small) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Product cannot be nil')
      end
    end

    context 'with nil variant' do
      it 'raises ValidationError' do
        expect { CoffeeApp::OrderItem.new(product: coffee, variant: nil) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Variant cannot be nil')
      end
    end
  end
end
