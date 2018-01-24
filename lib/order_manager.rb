# frozen_string_literal: true

class OrderManager
  attr_reader :users

  def initialize(products)
    @products = products
    @users = {}
  end

  def process_all(orders)
    parsed_list(orders).each do |item|
      user_name = user_name(item)
      @users[user_name.to_sym] = find_user(user_name).add_order(create_order(item))
    end

    self
  end

  def credit_all(payments)
    parsed_list(payments).each do |payment|
      user_name = user_name(payment)
      @users[user_name.to_sym] = find_user(user_name).pay(payment[:amount])
    end

    self
  end

  private

  def parsed_list(json)
    JsonParser.to_hash(json)
  end

  def create_order(item)
    Order.new.add_item(create_item(item))
  end

  def create_item(item)
    OrderItem.new(product: @products[item[:drink].to_sym], variant: item[:size].to_sym)
  end

  def find_user(user_name)
    @users[user_name.to_sym] ? @users[user_name.to_sym] : User.new(name: user_name)
  end

  def user_name(hash)
    hash[:user]
  end
end
