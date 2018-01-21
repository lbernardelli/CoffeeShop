class OrderFactory

  def initialize(orders)
    @raw_orders = JsonParser.to_hash(orders)
    @orders = []
  end

  def build
    @raw_orders.each do |raw_order|
      @orders << Order.new(user: User.new(name: raw_order[:user]),
                           coffee_name: raw_order[:drink],
                           coffee_size: raw_order[:size])
    end

    @orders
  end
end