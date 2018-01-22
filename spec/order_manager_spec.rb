# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OrderManager do
  let(:products) do
    {
      'long black': stub_coffee_price(Coffee.new(name: 'long black'), :medium, 2.25),
      'latte': stub_coffee_price(Coffee.new(name: 'latte'), :small, 1.50),
      'flat white': stub_coffee_price(Coffee.new(name: 'flat white'), :large, 3.50)
    }
  end

  subject { OrderManager.new(products).process_all(orders) }

  context 'Process an empty order list' do
    let(:orders) { nil }

    it('An empty list of users') { expect(subject.users).to be_empty }
  end

  context 'Process a list of orders' do
    let(:orders) do
      <<-JSON
      [
        {"user":"coach","drink":"long black","size":"medium"},
        {"user":"ellis","drink":"latte","size":"small"},
        {"user":"rochelle","drink":"flat white","size":"large"}
      ]
      JSON
    end

    it('3 users orders processed') { expect(subject.users.size).to be 3 }
    it('Coach ordered 2.25') { expect(subject.users[:coach].total_ordered?).to be 2.25 }
    it('ellis ordered 1.50') { expect(subject.users[:ellis].total_ordered?).to be 1.50 }
    it('rochelle ordered 3.50') { expect(subject.users[:rochelle].total_ordered?).to be 3.50 }
  end

  def stub_coffee_price(coffee, size, price)
    allow(coffee).to receive(:price?).with(size).and_return(price)
    coffee
  end
end