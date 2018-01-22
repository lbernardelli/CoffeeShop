# frozen_string_literal: true

require 'factories/coffee_factory'
require 'models/coffee'
require 'models/coffee_variant'
require 'models/order'
require 'models/user'
require 'models/order_item'
require 'utils/json_parser'
require 'order_manager'

class CoffeeApp
  def self.call(prices, orders, _payments)
    coffees = CoffeeFactory.new(prices).build
    manager = OrderManager.new(coffees)
    manager.process_all(orders)
  end
end
