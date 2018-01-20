class Coffee
  attr_reader :name, :sizes

  def initialize(name:)
    @name = name
    @sizes = []
  end

  def add_size(coffee_variant)
    @sizes << coffee_variant
    self
  end
end