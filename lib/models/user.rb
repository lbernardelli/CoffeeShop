# frozen_string_literal: true

class User
  attr_reader :name, :orders

  def initialize(name:)
    @name = name
    @orders = []
  end

  def add_order(order)
    @orders << order
    self
  end

  def total_ordered?
    @orders.inject(0.00) { |sum, order| sum + order.total? }
  end
end
