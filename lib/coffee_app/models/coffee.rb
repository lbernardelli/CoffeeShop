# frozen_string_literal: true

module CoffeeApp
  class Coffee
    attr_reader :name, :sizes

    def initialize(name:)
      @name = name
      @sizes = []
    end

    def add_size(coffee_variant)
      @sizes << coffee_variant
      self
    end

    def price(variant)
      size_variant = @sizes.find { |size_variant| size_variant.size.eql?(variant.to_sym) }

      size_variant ? size_variant.price : ValueObjects::Money.zero
    end
  end
end
