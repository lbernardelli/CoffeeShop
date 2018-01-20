class CoffeeFactory
  def initialize(prices)
    @prices = JSON.parse(prices, symbolize_names: true)
    @coffees = []
  end

  def build
    @prices.each do |item|
      coffee = Coffee.new(name: item[:drink_name])

      item[:prices].each do |price|
        coffee.add_size(CoffeeVariant.new({ size: price[0], price: price[1]}))
      end

      @coffees << coffee
    end

    @coffees
  end
end