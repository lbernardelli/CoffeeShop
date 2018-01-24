# frozen_string_literal: true

require 'coffee_app/factories/coffee_factory'
require 'coffee_app/models/coffee'
require 'coffee_app/models/coffee_variant'
require 'coffee_app/models/order'
require 'coffee_app/models/user'
require 'coffee_app/models/order_item'
require 'coffee_app/models/payment'
require 'coffee_app/utils/json_parser'
require 'coffee_app/order_manager'
require 'coffee_app/serializers/result_serializer'
require 'bigdecimal'

module CoffeeApp
  def self.call(prices, orders, payments)
    coffees = CoffeeApp::CoffeeFactory.new(prices).build
    manager = CoffeeApp::OrderManager.new(coffees).process_all(orders).credit_all(payments)

    CoffeeApp::ResultSerializer.serialize(manager.users).to_json
  end
end
