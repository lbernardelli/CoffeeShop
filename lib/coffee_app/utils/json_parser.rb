# frozen_string_literal: true

require_relative '../errors/parse_error'

module CoffeeApp
  class JsonParser
    def self.to_hash(json)
      return [] if json.nil? || json.strip.empty?

      JSON.parse(json, symbolize_names: true)
    rescue JSON::ParserError => e
      raise Errors::ParseError.new(
        "Failed to parse JSON: #{e.message}",
        original_error: e,
        input: json
      )
    end
  end
end
