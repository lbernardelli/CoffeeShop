class Coffee
  attr_reader :name, :sizes

  def initialize(name:)
    @name = name
    @sizes = []
  end

  def add_size(coffee_size)
    @sizes << coffee_size
    self
  end
end