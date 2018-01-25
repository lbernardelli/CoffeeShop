# frozen_string_literal: true

module CoffeeApp
  class OrderManager
    attr_reader :users

    def initialize(products)
      @user_repository = Repositories::UserRepository.new
      @order_service = Services::OrderService.new(products, @user_repository)
      @payment_service = Services::PaymentService.new(@user_repository)
    end

    def process_all(orders)
      @order_service.process_orders(orders)
      self
    end

    def credit_all(payments)
      @payment_service.process_payments(payments)
      self
    end

    def users
      @user_repository.all
    end
  end
end
