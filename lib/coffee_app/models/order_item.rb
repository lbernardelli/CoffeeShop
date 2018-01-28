# frozen_string_literal: true

module CoffeeApp
  class OrderItem
    attr_reader :product, :variant

    def initialize(product:, variant:)
      validate_product(product)
      validate_variant(variant)
      @product = product
      @variant = variant
    end

    def price
      @product.price(@variant)
    end

    private

    def validate_product(product)
      if product.nil?
        raise Errors::ValidationError.new(
          'Product cannot be nil',
          field: :product,
          value: product
        )
      end
    end

    def validate_variant(variant)
      if variant.nil?
        raise Errors::ValidationError.new(
          'Variant cannot be nil',
          field: :variant,
          value: variant
        )
      end
    end
  end
end
