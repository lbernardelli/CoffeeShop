# frozen_string_literal: true

require_relative 'serializers/user_serializer'

module CoffeeApp
  class User
    include Serializers::UserSerializer

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
      @payments << CoffeeApp::Payment.new(amount: amount)
      self
    end

    # Balance is calculated on what each user owe, so ordered - payed
    def balance?
      BigDecimal.new(total_ordered?.to_s) - BigDecimal.new(total_payed?.to_s)
    end

    def total_payed?
      @payments.inject(BigDecimal.new('0.00')) { |sum, payment| BigDecimal.new(sum.to_s) + BigDecimal.new(payment.amount.to_s) }
    end
  end
end
