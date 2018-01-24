# frozen_string_literal: true

module CoffeeApp
  class JsonParser
    def self.to_hash(json)
      JSON.parse(json, symbolize_names: true)
    rescue StandardError
      []
    end
  end
end
