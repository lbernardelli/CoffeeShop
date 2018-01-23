# frozen_string_literal: true

class User
  attr_reader :name, :orders

  def initialize(name:)
    @name = name
    @orders = []
    @payments = []
  end

  def add_order(order)
    @orders << order
    self
  end

  def total_ordered?
    @orders.inject(BigDecimal.new('0.00')) { |sum, order| BigDecimal.new(sum.to_s) + BigDecimal.new(order.total?.to_s) }
  end

  def pay(amount)
    @payments << Payment.new(amount: amount)
    self
  end

  def balance?
    (BigDecimal.new(total_payed?.to_s) - BigDecimal.new(total_ordered?.to_s)).abs
  end

  def total_payed?
    @payments.inject(BigDecimal.new('0.00')) { |sum, payment| BigDecimal.new(sum.to_s) + BigDecimal.new(payment.amount.to_s) }
  end
end
