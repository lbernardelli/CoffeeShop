# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::ResultSerializer do
  describe '.serialize' do
    context 'with empty users hash' do
      it 'returns empty array' do
        result = CoffeeApp::ResultSerializer.serialize({})
        expect(result).to eq([])
      end
    end

    context 'with single user' do
      it 'returns array with one user hash' do
        user = CoffeeApp::User.new(name: 'Alice')
        users = { Alice: user }

        result = CoffeeApp::ResultSerializer.serialize(users)

        expect(result.size).to eq(1)
        expect(result.first[:user]).to eq('Alice')
        expect(result.first[:order_total]).to eq(0.0)
        expect(result.first[:payment_total]).to eq(0.0)
        expect(result.first[:balance]).to eq(0.0)
      end
    end

    context 'with multiple users' do
      it 'returns array with all user hashes' do
        user1 = CoffeeApp::User.new(name: 'Alice')
        user2 = CoffeeApp::User.new(name: 'Bob')
        user1.pay(10.00)
        user2.pay(5.00)

        users = { Alice: user1, Bob: user2 }

        result = CoffeeApp::ResultSerializer.serialize(users)

        expect(result.size).to eq(2)

        alice_result = result.find { |u| u[:user] == 'Alice' }
        bob_result = result.find { |u| u[:user] == 'Bob' }

        expect(alice_result[:payment_total]).to eq(10.0)
        expect(bob_result[:payment_total]).to eq(5.0)
      end
    end

    context 'with users having orders and payments' do
      it 'returns serialized data with correct calculations' do
        user = CoffeeApp::User.new(name: 'Charlie')
        order = CoffeeApp::Order.new

        coffee_variant = CoffeeApp::CoffeeVariant.new(size: :small, price: 3.50)
        coffee = CoffeeApp::Coffee.new(name: 'latte').add_size(coffee_variant)
        order.add_item(CoffeeApp::OrderItem.new(product: coffee, variant: :small))

        user.add_order(order)
        user.pay(5.00)

        users = { Charlie: user }

        result = CoffeeApp::ResultSerializer.serialize(users)

        expect(result.size).to eq(1)
        expect(result.first[:user]).to eq('Charlie')
        expect(result.first[:order_total]).to eq(3.50)
        expect(result.first[:payment_total]).to eq(5.0)
        expect(result.first[:balance]).to eq(-1.5)
      end
    end
  end
end
