# frozen_string_literal: true

module CoffeeApp
  module Repositories
    class UserRepository
      def initialize
        @users = {}
      end

      def find_or_create(user_name)
        @users[user_name.to_sym] ||= CoffeeApp::User.new(name: user_name)
      end

      def save(user)
        @users[user.name.to_sym] = user
      end

      def all
        @users
      end
    end
  end
end
