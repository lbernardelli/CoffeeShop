# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::User do
  let(:user) { CoffeeApp::User.new(name: 'Micheal') }

  describe 'total_ordered?' do
    subject { user.total_ordered? }

    context 'Empty order' do
      it('Total ordered is 0.00') { is_expected.to eql BigDecimal.new('0.00') }
    end

    context 'User ordered 1 product' do
      before { user.add_order(create_order_double(1.00)) }

      it('ordered a total of 1.00') { is_expected.to eql BigDecimal.new('1.00') }
    end

    context 'User ordered a bunch of products' do
      before do
        user.add_order(create_order_double(1.00))
        user.add_order(create_order_double(2.25))
        user.add_order(create_order_double(3.50))
      end

      it('has a total of 7.00') { is_expected.to eql BigDecimal.new('6.75') }
    end
  end

  describe 'total_payed?' do
    subject { user.total_payed? }

    context 'No payments' do
      it('payed a total of 0.00') { is_expected.to eql BigDecimal.new('0.00') }
    end

    context 'User payed 1.00' do
      before { user.pay(1.00) }

      it('payed a total of 1.00') { is_expected.to eql BigDecimal.new('1.00') }
    end

    context 'User had ordered a bunch of products' do
      before do
        user.pay(1.00)
        user.pay(2.5)
        user.pay(3.53)
      end

      it('has a total of 7.03') { is_expected.to eql BigDecimal.new('7.03') }
    end
  end

  describe 'balance' do
    subject { user.balance? }

    context 'No orders nor payments' do
      it('has a balance of 0.00') { is_expected.to eql BigDecimal.new('0.00') }
    end

    context 'User had ordered 1 product' do
      before { user.add_order(create_order_double(1.00)) }

      it('has a balance of 1.00') { is_expected.to eql BigDecimal.new('1.00') }
    end

    context 'User payed 1.00' do
      before { user.pay(1.00) }

      # User has a 1.00 credit
      it('has a balance of -1.00') { is_expected.to eql BigDecimal.new('-1.00') }
    end

    context 'User ordered 1.00 and payed 1.00' do
      before do
        user.add_order(create_order_double(1.00))
        user.pay(1.00)
      end

      it('has a balance of 0.00') { is_expected.to eql BigDecimal.new('0.00') }
    end
  end

  def create_order_double(price)
    object_double(CoffeeApp::Order.new, total?: price)
  end
end
