# frozen_string_literal: true

module CoffeeApp
  class OrderItem
    def initialize(product:, variant:)
      @product = product
      @variant = variant
    end

    def price?
      @product.price?(@variant)
    end
  end
end
