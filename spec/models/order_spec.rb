# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Order do
  describe 'Total' do
    let(:order) { CoffeeApp::Order.new }
    context 'Empty order' do
      subject { order }

      it 'Total is 0.00' do
        expect(subject.total).to eql BigDecimal.new('0.00')
      end
    end

    context 'Order has 1 item' do
      subject do
        order.add_item(create_item_double(1.00))
      end

      it('has a total of 1.00') { expect(subject.total).to eql BigDecimal.new('1.00') }
    end

    context 'Order has a bunch of items' do
      subject do
        order.add_item(create_item_double(2.00))
        order.add_item(create_item_double(3.50))
        order.add_item(create_item_double(1.75))
      end

      it('has a total of 7.00') { expect(subject.total).to eql BigDecimal.new('7.25') }
    end

    def create_item_double(price)
      object_double(CoffeeApp::OrderItem.new(product: nil, variant: nil), price: price)
    end
  end
end
