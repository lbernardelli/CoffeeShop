# frozen_string_literal: true

module CoffeeApp
  class Payment
    attr_reader :amount

    def initialize(amount:)
      @amount = ValueObjects::Money.new(amount)
    end
  end
end
