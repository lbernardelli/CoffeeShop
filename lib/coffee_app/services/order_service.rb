# frozen_string_literal: true

module CoffeeApp
  module Services
    class OrderService
      def initialize(products, user_repository)
        @products = products
        @user_repository = user_repository
      end

      def process_orders(orders_data)
        parsed_orders = parse_json(orders_data)

        parsed_orders.each do |order_data|
          user_name = extract_user_name(order_data)
          user = @user_repository.find_or_create(user_name)
          order = build_order(order_data)

          user.add_order(order)
          @user_repository.save(user)
        end
      end

      private

      def parse_json(json)
        CoffeeApp::JsonParser.to_hash(json)
      end

      def extract_user_name(data)
        data[:user]
      end

      def build_order(order_data)
        order = CoffeeApp::Order.new
        item = build_order_item(order_data)
        order.add_item(item)
      end

      def build_order_item(order_data)
        product = @products[order_data[:drink].to_sym]
        variant = order_data[:size].to_sym
        CoffeeApp::OrderItem.new(product: product, variant: variant)
      end
    end
  end
end
