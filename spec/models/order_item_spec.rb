# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OrderItem do
  describe 'price?' do
    context 'Find a product price' do
      subject do
        coffee_variant = CoffeeVariant.new(size: :small, price: 1.00)
        coffee = Coffee.new(name: 'coffee name').add_size(coffee_variant)

        OrderItem.new(variant: :small, product: coffee).price?
      end

      it('Has the variant price') { expect(subject).to be 1.00 }
    end

    context 'Find a product price from inconsistent order item' do
      subject do
        coffee_variant = CoffeeVariant.new(size: :small, price: 1.00)
        coffee = Coffee.new(name: 'coffee name').add_size(coffee_variant)

        OrderItem.new(variant: :large, product: coffee).price?
      end

      it('The price is 0.00') { expect(subject).to be 0.00 }
    end
  end
end
