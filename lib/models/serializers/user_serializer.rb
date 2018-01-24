module Serializers
  module UserSerializer
    def serialize
      {
        user: @name,
        order_total: total_ordered?.to_f,
        payment_total: total_payed?.to_f,
        balance: balance?.to_f
      }
    end
  end
end
