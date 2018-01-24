# frozen_string_literal: true

module CoffeeApp
  class CoffeeVariant
    attr_reader :size, :price

    def initialize(attr)
      @size = attr[:size]
      @price = BigDecimal.new(attr[:price].to_s)
    end
  end
end
