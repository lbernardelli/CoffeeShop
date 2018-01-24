# frozen_string_literal: true

module CoffeeApp
  class ResultSerializer
    def self.serialize(users)
      result = []

      users.each_value do |user|
        result << user.serialize
      end

      result
    end
  end
end
