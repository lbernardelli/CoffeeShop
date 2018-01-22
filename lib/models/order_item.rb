# frozen_string_literal: true

class OrderItem
  def initialize(product:, variant:)
    @product = product
    @variant = variant
  end

  def price?
    @product.price?(@variant)
  end
end
