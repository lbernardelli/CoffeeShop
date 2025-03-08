# frozen_string_literal: true

module CoffeeApp
  class NullCoffee
    attr_reader :name

    def initialize(name: 'Unknown')
      @name = name
    end

    def price(_variant) = ValueObjects::Money.zero

    def add_size(_coffee_variant) = self

    def sizes = []

    def null_object? = true
  end
end
