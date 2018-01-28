# frozen_string_literal: true

module CoffeeApp
  class NullCoffee
    attr_reader :name

    def initialize(name: 'Unknown')
      @name = name
    end

    def price(_variant)
      ValueObjects::Money.zero
    end

    def add_size(_coffee_variant)
      self
    end

    def sizes
      []
    end

    def null_object?
      true
    end
  end
end
