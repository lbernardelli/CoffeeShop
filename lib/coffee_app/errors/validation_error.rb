# frozen_string_literal: true

module CoffeeApp
  module Errors
    class ValidationError < StandardError
      attr_reader :field, :value

      def initialize(message, field: nil, value: nil)
        @field = field
        @value = value
        super(message)
      end
    end
  end
end
