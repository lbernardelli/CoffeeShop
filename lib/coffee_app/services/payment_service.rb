# frozen_string_literal: true

module CoffeeApp
  module Services
    class PaymentService
      include Concerns::JsonParseable

      def initialize(user_repository)
        @user_repository = user_repository
      end

      def process_payments(payments_data)
        parsed_payments = parse_json(payments_data)

        parsed_payments.each do |payment_data|
          user_name = extract_user_name(payment_data)
          user = @user_repository.find_or_create(user_name)
          amount = payment_data[:amount]

          user.pay(amount)
          @user_repository.save(user)
        end
      end

      private
    end
  end
end
