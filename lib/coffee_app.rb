# frozen_string_literal: true

require 'bigdecimal'
require 'coffee_app/errors/parse_error'
require 'coffee_app/errors/validation_error'
require 'coffee_app/value_objects/money'
require 'coffee_app/factories/coffee_factory'
require 'coffee_app/utils/json_parser'
require 'coffee_app/repositories/user_repository'
require 'coffee_app/services/order_service'
require 'coffee_app/services/payment_service'
require 'coffee_app/presenters/user_presenter'
require 'coffee_app/order_manager'
require 'coffee_app/serializers/result_serializer'

Dir[File.expand_path('../coffee_app/models/*.rb', __FILE__)].map do |path|
  require path
end

module CoffeeApp
  def self.call(prices, orders, payments)
    coffees = CoffeeApp::CoffeeFactory.new(prices).build
    manager = CoffeeApp::OrderManager.new(coffees).process_all(orders).credit_all(payments)

    CoffeeApp::ResultSerializer.serialize(manager.users).to_json
  end
end
