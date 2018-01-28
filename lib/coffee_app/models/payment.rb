# frozen_string_literal: true

module CoffeeApp
  class Payment
    attr_reader :amount

    def initialize(amount:)
      @amount = ValueObjects::Money.new(amount)
      validate_non_negative
    end

    private

    def validate_non_negative
      if @amount.negative?
        raise Errors::ValidationError.new(
          'Payment amount cannot be negative',
          field: :amount,
          value: @amount.to_f
        )
      end
    end
  end
end
