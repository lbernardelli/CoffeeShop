# frozen_string_literal: true

module CoffeeApp
  module ValueObjects
    class Money
      include Comparable

      attr_reader :amount

      def initialize(amount)
        @amount = BigDecimal.new(amount.to_s)
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

      def to_f
        @amount.to_f
      end

      def to_s
        @amount.to_s('F')
      end

      def inspect
        "#<Money #{to_s}>"
      end

      def zero?
        @amount.zero?
      end

      def positive?
        @amount > 0
      end

      def negative?
        @amount < 0
      end
    end
  end
end
