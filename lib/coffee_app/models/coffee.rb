# frozen_string_literal: true

module CoffeeApp
  class Coffee
    attr_reader :name, :sizes

    def initialize(name:)
      validate_name(name)
      @name = name
      @sizes = []
    end

    def add_size(coffee_variant)
      @sizes << coffee_variant
      self
    end

    def price(variant)
      normalized_variant = Support::SymbolKey.normalize(variant)
      size_variant = @sizes.find { |size_variant| size_variant.size.eql?(normalized_variant) }

      size_variant ? size_variant.price : ValueObjects::Money.zero
    end

    def null_object? = false

    private

    def validate_name(name)
      if name.nil? || name.to_s.strip.empty?
        raise Errors::ValidationError.new(
          'Coffee name cannot be empty',
          field: :name,
          value: name
        )
      end
    end
  end
end
