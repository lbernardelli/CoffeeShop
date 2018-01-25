# frozen_string_literal: true

module CoffeeApp
  class Order
    attr_reader :items

    def initialize
      @items = []
    end

    def add_item(item)
      @items << item
      self
    end

    def total
      items.inject(BigDecimal.new('0.00')) { |sum, item| BigDecimal.new(sum.to_s) + BigDecimal.new(item.price.to_s) }
    end
  end
end
