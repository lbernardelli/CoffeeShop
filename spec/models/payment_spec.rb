# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Payment do
  describe '#initialize' do
    context 'with valid positive amount' do
      it 'creates payment successfully' do
        payment = CoffeeApp::Payment.new(amount: 10.50)
        expect(payment.amount.to_f).to eq(10.50)
      end
    end

    context 'with zero amount' do
      it 'creates payment successfully' do
        payment = CoffeeApp::Payment.new(amount: 0)
        expect(payment.amount.to_f).to eq(0.0)
      end
    end

    context 'with negative amount' do
      it 'raises ValidationError' do
        expect { CoffeeApp::Payment.new(amount: -10.50) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Payment amount cannot be negative')
      end
    end

    context 'with nil amount' do
      it 'raises ValidationError from Money' do
        expect { CoffeeApp::Payment.new(amount: nil) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Amount cannot be nil')
      end
    end
  end
end
