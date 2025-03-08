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
      items.inject(ValueObjects::Money.zero) { _1 + _2.price }
    end
  end
end
