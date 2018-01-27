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

    def total_ordered
      @orders.inject(ValueObjects::Money.zero) { |sum, order| sum + order.total }
    end

    def pay(amount)
      @payments << CoffeeApp::Payment.new(amount: amount)
      self
    end

    # Balance is calculated on what each user owe, so ordered - paid
    def balance
      total_ordered - total_paid
    end

    def total_paid
      @payments.inject(ValueObjects::Money.zero) { |sum, payment| sum + payment.amount }
    end
  end
end
