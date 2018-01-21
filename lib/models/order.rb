class Order
  attr_reader :user, :coffee_name, :coffee_size

  def initialize(attrs = {})
    @user = attrs[:user]
    @coffee_name = attrs[:coffee_name]
    @coffee_size = attrs[:coffee_size]&.to_sym
  end
end