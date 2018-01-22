# frozen_string_literal: true

class Order
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
    self
  end

  def total?
    items.inject(0.00) { |sum, item| sum + item.price? }
  end
end
