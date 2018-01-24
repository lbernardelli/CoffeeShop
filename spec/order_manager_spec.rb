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

  describe 'process_all' do
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
      it('Coach ordered 2.25') { expect(subject.users[:coach].total_ordered?).to eql BigDecimal.new('2.25') }
      it('ellis ordered 1.50') { expect(subject.users[:ellis].total_ordered?).to eql BigDecimal.new('1.50') }
      it('rochelle ordered 3.50') { expect(subject.users[:rochelle].total_ordered?).to eql BigDecimal.new('3.50') }
    end

    def stub_coffee_price(coffee, size, price)
      allow(coffee).to receive(:price?).with(size).and_return(price)
      coffee
    end
  end

  describe 'credit_all' do
    subject { OrderManager.new(products).credit_all(payments) }

    context 'Process an empty payment list' do
      let(:payments) { nil }

      it('An empty list of users') { expect(subject.users).to be_empty }
    end

    context 'Process a list of payments' do
      let(:payments) do
        <<-JSON
      [
        {"user":"coach","amount":15.4},
        {"user":"rochelle","amount":7.75},
        {"user":"coach","amount":10.09},
        {"user":"ellis","amount":0.00}
      ]
        JSON
      end

      it('3 users payments processed') { expect(subject.users.size).to be 3 }
      it('Coach payed 25.49') { expect(subject.users[:coach].total_payed?).to eql BigDecimal.new('25.49') }
      it('rochelle payed 7.75') { expect(subject.users[:rochelle].total_payed?).to eql BigDecimal.new('7.75') }
      it('ellis payed 0.00') { expect(subject.users[:ellis].total_payed?).to eql BigDecimal.new('0.00') }
    end
  end

  def stub_coffee_price(coffee, size, price)
    allow(coffee).to receive(:price?).with(size).and_return(price)
    coffee
  end
end