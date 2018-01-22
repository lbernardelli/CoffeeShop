# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User do
  describe 'total_ordered?' do
    let(:user) { User.new(name: 'Micheal') }
    context 'Empty order' do
      subject { user }

      it 'Total ordered is 0.00' do
        expect(subject.total_ordered?).to be 0.00
      end
    end

    context 'User has ordered 1 product' do
      subject do
        user.add_order(create_order_double(1.00))
      end

      it('had ordered a total of 1.00') { expect(subject.total_ordered?).to be 1.00 }
    end

    context 'User had ordered a bunch of products' do
      subject do
        user.add_order(create_order_double(1.00))
        user.add_order(create_order_double(2.25))
        user.add_order(create_order_double(3.50))
      end

      it('has a total of 7.00') { expect(subject.total_ordered?).to be 6.75 }
    end

    def create_order_double(price)
      object_double(Order.new, total?: price)
    end
  end
end
