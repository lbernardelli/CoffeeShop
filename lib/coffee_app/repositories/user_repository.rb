# frozen_string_literal: true

module CoffeeApp
  module Repositories
    class UserRepository
      def initialize
        @users = {}
      end

      def find_or_create(user_name)
        key = Support::SymbolKey.normalize(user_name)
        @users[key] ||= CoffeeApp::User.new(name: user_name)
      end

      def save(user)
        key = Support::SymbolKey.normalize(user.name)
        @users[key] = user
      end

      def all
        @users
      end
    end
  end
end
