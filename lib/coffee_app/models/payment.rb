# frozen_string_literal: true

module CoffeeApp
  class Payment
    attr_reader :amount

    def initialize(amount:)
      @amount = BigDecimal.new(amount.to_s)
    end
  end
end
