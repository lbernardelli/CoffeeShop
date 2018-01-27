# frozen_string_literal: true

module CoffeeApp
  class ResultSerializer
    def self.serialize(users)
      users.each_value.map do |user|
        Presenters::UserPresenter.new(user).to_hash
      end
    end
  end
end
