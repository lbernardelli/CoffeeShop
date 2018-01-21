require 'factories/coffee_factory'
require 'factories/order_factory'
require 'models/coffee'
require 'models/coffee_variant'
require 'models/order'
require 'models/user'
require 'utils/json_parser'

class CoffeeApp
  def self.call(prices, orders, payments)
    @coffees = CoffeeFactory.new(prices).build
    @orders = OrderFactory.new(orders).build

  end
end

