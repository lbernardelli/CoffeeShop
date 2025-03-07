# frozen_string_literal: true

module CoffeeApp
  module ValueObjects
    class Money
      include Comparable

      attr_reader :amount

      def initialize(amount)
        validate_amount(amount)
        @amount = BigDecimal(amount.to_s).freeze
        freeze
      end

      def self.zero
        new(0)
      end

      def +(other)
        Money.new(@amount + other.amount)
      end

      def -(other)
        Money.new(@amount - other.amount)
      end

      def *(multiplier)
        Money.new(@amount * multiplier)
      end

      def /(divisor)
        Money.new(@amount / divisor)
      end

      def <=>(other)
        @amount <=> other.amount
      end

      def ==(other)
        return false unless other.is_a?(Money)

        @amount == other.amount
      end

      alias eql? ==

      def hash
        @amount.hash
      end

      def to_f = @amount.to_f

      def to_s = @amount.to_s('F')

      def inspect = "#<Money #{to_s}>"

      def zero? = @amount.zero?

      def positive? = @amount > 0

      def negative? = @amount < 0

      private

      def validate_amount(amount)
        if amount.nil?
          raise CoffeeApp::Errors::ValidationError.new(
            'Amount cannot be nil',
            field: :amount,
            value: amount
          )
        end

        # Check if the value can be converted to a valid number
        begin
          numeric_value = BigDecimal(amount.to_s)
        rescue ArgumentError, TypeError => e
          raise CoffeeApp::Errors::ValidationError.new(
            "Invalid amount: #{amount.inspect}",
            field: :amount,
            value: amount
          )
        end
      end
    end
  end
end
