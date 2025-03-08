# frozen_string_literal: true

module CoffeeApp
  class ResultSerializer
    def self.serialize(users)
      users.each_value.map { Presenters::UserPresenter.new(_1).to_hash }
    end
  end
end
