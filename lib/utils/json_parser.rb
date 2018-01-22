# frozen_string_literal: true

class JsonParser
  def self.to_hash(json)
    JSON.parse(json, symbolize_names: true)
  rescue JSON::ParserError, StandardError
    []
  end
end
