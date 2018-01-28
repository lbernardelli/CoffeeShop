# frozen_string_literal: true

module CoffeeApp
  module Services
    class OrderService
      include Concerns::JsonParseable

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

      def build_order(order_data)
        order = CoffeeApp::Order.new
        item = build_order_item(order_data)
        order.add_item(item)
      end

      def build_order_item(order_data)
        drink_name = order_data[:drink]
        product = find_product(drink_name)
        variant = Support::SymbolKey.normalize(order_data[:size])
        CoffeeApp::OrderItem.new(product: product, variant: variant)
      end

      def find_product(drink_name)
        key = Support::SymbolKey.normalize(drink_name)
        product = @products[key]

        unless product
          raise Errors::ValidationError.new(
            "Unknown drink: #{drink_name}",
            field: :drink,
            value: drink_name
          )
        end

        product
      end
    end
  end
end
