# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Services::OrderService do
  let(:products) do
    {
      latte: stub_coffee_price(CoffeeApp::Coffee.new(name: 'latte'), :small, 3.50),
      mocha: stub_coffee_price(CoffeeApp::Coffee.new(name: 'mocha'), :medium, 4.00)
    }
  end
  let(:user_repository) { CoffeeApp::Repositories::UserRepository.new }
  let(:service) { CoffeeApp::Services::OrderService.new(products, user_repository) }

  describe '#process_orders' do
    context 'with valid orders JSON' do
      let(:orders_json) do
        <<-JSON
        [
          {"user":"alice","drink":"latte","size":"small"},
          {"user":"bob","drink":"mocha","size":"medium"}
        ]
        JSON
      end

      it 'processes all orders' do
        service.process_orders(orders_json)

        alice = user_repository.all[:alice]
        bob = user_repository.all[:bob]

        expect(alice.orders.size).to eq(1)
        expect(bob.orders.size).to eq(1)
        expect(alice.total_ordered.to_f).to eq(3.50)
        expect(bob.total_ordered.to_f).to eq(4.00)
      end
    end

    context 'with multiple orders for same user' do
      let(:orders_json) do
        <<-JSON
        [
          {"user":"charlie","drink":"latte","size":"small"},
          {"user":"charlie","drink":"mocha","size":"medium"}
        ]
        JSON
      end

      it 'accumulates orders for the user' do
        service.process_orders(orders_json)

        charlie = user_repository.all[:charlie]
        expect(charlie.orders.size).to eq(2)
        expect(charlie.total_ordered.to_f).to eq(7.50)
      end
    end

    context 'with empty orders' do
      it 'does not create any users' do
        service.process_orders('')
        expect(user_repository.all).to be_empty
      end
    end
  end

  def stub_coffee_price(coffee, size, price)
    allow(coffee).to receive(:price).with(size).and_return(price)
    coffee
  end
end
