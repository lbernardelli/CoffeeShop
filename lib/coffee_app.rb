# frozen_string_literal: true

require 'factories/coffee_factory'
require 'models/coffee'
require 'models/coffee_variant'
require 'models/order'
require 'models/user'
require 'models/order_item'
require 'models/payment'
require 'utils/json_parser'
require 'order_manager'
require 'bigdecimal'
require 'serializers/result_serializer'

class CoffeeApp
  def self.call(prices, orders, payments)
    coffees = CoffeeFactory.new(prices).build
    manager = OrderManager.new(coffees).process_all(orders).credit_all(payments)

    ResultSerializer.serialize(manager.users).to_json
  end
end
