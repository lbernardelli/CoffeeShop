# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Order do
  describe 'Total' do
    let(:order) { Order.new }
    context 'Empty order' do
      subject { order }

      it 'Total is 0.00' do
        expect(subject.total).to be 0.00
      end
    end

    context 'Order has 1 item' do
      subject do
        coffee_variant = CoffeeVariant.new(size: :small, price: 1.00)
        order.add_item(product: Coffee.new(name: 'latte').add_size(coffee_variant),
                       variant: :small)
      end

      it('has a total of 1.00') { expect(subject.total).to be 1.00 }
    end

    context 'Order has s bunch of items' do
      subject do
        coffee_variant = CoffeeVariant.new(size: :small, price: 1.00)
        order.add_item(product: Coffee.new(name: 'latte').add_size(coffee_variant),
                       variant: :small)
        order.add_item(product: Coffee.new(name: 'mocha').add_size(coffee_variant),
                       variant: :small)
        order.add_item(product: Coffee.new(name: 'regular').add_size(coffee_variant),
                       variant: :small)
      end

      it('has a total of 3.00') { expect(subject.total).to be 3.00 }
    end
  end
end
