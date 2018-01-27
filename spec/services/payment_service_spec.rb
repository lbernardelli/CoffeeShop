# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Services::PaymentService do
  let(:user_repository) { CoffeeApp::Repositories::UserRepository.new }
  let(:service) { CoffeeApp::Services::PaymentService.new(user_repository) }

  describe '#process_payments' do
    context 'with valid payments JSON' do
      let(:payments_json) do
        <<-JSON
        [
          {"user":"alice","amount":10.00},
          {"user":"bob","amount":5.50}
        ]
        JSON
      end

      it 'processes all payments' do
        service.process_payments(payments_json)

        alice = user_repository.all[:alice]
        bob = user_repository.all[:bob]

        expect(alice.total_paid.to_f).to eq('10.00'))
        expect(bob.total_paid.to_f).to eq('5.50'))
      end
    end

    context 'with multiple payments for same user' do
      let(:payments_json) do
        <<-JSON
        [
          {"user":"charlie","amount":10.00},
          {"user":"charlie","amount":15.00}
        ]
        JSON
      end

      it 'accumulates payments for the user' do
        service.process_payments(payments_json)

        charlie = user_repository.all[:charlie]
        expect(charlie.total_paid.to_f).to eq('25.00'))
      end
    end

    context 'with empty payments' do
      it 'does not create any users' do
        service.process_payments('')
        expect(user_repository.all).to be_empty
      end
    end

    context 'with zero amount payment' do
      let(:payments_json) do
        <<-JSON
        [
          {"user":"dave","amount":0.00}
        ]
        JSON
      end

      it 'processes zero amount payment' do
        service.process_payments(payments_json)

        dave = user_repository.all[:dave]
        expect(dave.total_paid.to_f).to eq('0.00'))
      end
    end
  end
end
