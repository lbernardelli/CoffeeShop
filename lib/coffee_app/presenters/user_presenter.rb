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
          order_total: @user.formatted_total_ordered,
          payment_total: @user.formatted_total_paid,
          balance: @user.formatted_balance
        }
      end

      def to_json(*_args)
        to_hash.to_json
      end
    end
  end
end
