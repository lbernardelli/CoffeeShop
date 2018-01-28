# frozen_string_literal: true

module CoffeeApp
  class User
    attr_reader :name, :orders

    def initialize(name:)
      validate_name(name)
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

    def formatted_total_ordered
      total_ordered.to_f
    end

    def formatted_total_paid
      total_paid.to_f
    end

    def formatted_balance
      balance.to_f
    end

    private

    def validate_name(name)
      if name.nil? || name.to_s.strip.empty?
        raise Errors::ValidationError.new(
          'User name cannot be empty',
          field: :name,
          value: name
        )
      end
    end
  end
end
