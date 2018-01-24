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

    def price?(variant)
      price = @sizes.select { |size_variant| size_variant.size.eql?(variant.to_sym) }[0]&.price

      price ? BigDecimal(price.to_s) : BigDecimal.new('0.00')
    end
  end
end
