class CoffeeSize
  attr_reader :size, :price

  def initialize(attr)
    @size = attr[:size]
    @price = attr[:price]
  end
end