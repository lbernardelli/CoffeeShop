# frozen_string_literal: true

module CoffeeApp
  class CoffeeVariant
    attr_reader :size, :price

    def initialize(attr)
      @size = attr[:size]
      @price = ValueObjects::Money.new(attr[:price])
    end
  end
end
