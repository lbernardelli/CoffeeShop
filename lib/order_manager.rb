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

  private

  def parsed_list(orders)
    JsonParser.to_hash(orders)
  end

  def create_order(item)
    Order.new.add_item(create_item(item))
  end

  def create_item(item)
    OrderItem.new(product: @products[item[:drink].to_sym], variant: item[:size].to_sym)
  end

  def find_user(user_name)
    @users[:user] ? @users[:user_name] : User.new(name: user_name)
  end

  def user_name(item)
    item[:user]
  end
end
