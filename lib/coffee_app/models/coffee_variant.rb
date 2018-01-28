# frozen_string_literal: true

module CoffeeApp
  class CoffeeVariant
    attr_reader :size, :price

    def initialize(attr)
      validate_size(attr[:size])
      @size = attr[:size]
      @price = ValueObjects::Money.new(attr[:price])
      validate_positive_price
    end

    private

    def validate_size(size)
      if size.nil? || size.to_s.strip.empty?
        raise Errors::ValidationError.new(
          'Size cannot be empty',
          field: :size,
          value: size
        )
      end
    end

    def validate_positive_price
      unless @price.positive?
        raise Errors::ValidationError.new(
          'Price must be positive',
          field: :price,
          value: @price.to_f
        )
      end
    end
  end
end
