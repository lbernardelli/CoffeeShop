# frozen_string_literal: true

module CoffeeApp
  class CoffeeFactory
    def initialize(prices)
      @prices = JsonParser.to_hash(prices)
      @coffees = {}
    end

    def build
      @prices.each do |item|
        coffee = Coffee.new(name: item[:drink_name])

        item[:prices].each do |price|
          coffee.add_size(CoffeeVariant.new(size: price[0], price: price[1]))
        end

        key = Support::SymbolKey.normalize(coffee.name)
        @coffees[key] = coffee
      end

      @coffees
    end
  end
end
