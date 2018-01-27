# frozen_string_literal: true

module CoffeeApp
  module Presenters
    class UserPresenter
      def initialize(user)
        @user = user
      end

      def to_hash
        {
          user: @user.name,
          order_total: @user.total_ordered.to_f,
          payment_total: @user.total_paid.to_f,
          balance: @user.balance.to_f
        }
      end

      def to_json(*_args)
        to_hash.to_json
      end
    end
  end
end
