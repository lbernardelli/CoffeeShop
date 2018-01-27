# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Presenters::UserPresenter do
  let(:user) { CoffeeApp::User.new(name: 'Alice') }
  let(:presenter) { CoffeeApp::Presenters::UserPresenter.new(user) }

  describe '#to_hash' do
    context 'with a user who has no orders or payments' do
      it 'returns hash with zero values' do
        result = presenter.to_hash

        expect(result[:user]).to eq('Alice')
        expect(result[:order_total]).to eq(0.0)
        expect(result[:payment_total]).to eq(0.0)
        expect(result[:balance]).to eq(0.0)
      end
    end

    context 'with a user who has orders' do
      before do
        order = create_order_with_total(10.50)
        user.add_order(order)
      end

      it 'returns hash with order total' do
        result = presenter.to_hash

        expect(result[:user]).to eq('Alice')
        expect(result[:order_total]).to eq(10.50)
        expect(result[:payment_total]).to eq(0.0)
        expect(result[:balance]).to eq(10.50)
      end
    end

    context 'with a user who has payments' do
      before do
        user.pay(5.25)
      end

      it 'returns hash with payment total' do
        result = presenter.to_hash

        expect(result[:user]).to eq('Alice')
        expect(result[:order_total]).to eq(0.0)
        expect(result[:payment_total]).to eq(5.25)
        expect(result[:balance]).to eq(-5.25)
      end
    end

    context 'with a user who has both orders and payments' do
      before do
        order1 = create_order_with_total(10.50)
        order2 = create_order_with_total(7.25)
        user.add_order(order1)
        user.add_order(order2)
        user.pay(15.00)
      end

      it 'returns hash with calculated balance' do
        result = presenter.to_hash

        expect(result[:user]).to eq('Alice')
        expect(result[:order_total]).to eq(17.75)
        expect(result[:payment_total]).to eq(15.00)
        expect(result[:balance]).to eq(2.75)
      end
    end
  end

  def create_order_with_total(amount)
    order = CoffeeApp::Order.new
    item = double('OrderItem', price: CoffeeApp::ValueObjects::Money.new(amount))
    order.add_item(item)
    order
  end
end
