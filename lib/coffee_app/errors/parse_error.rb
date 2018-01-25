# frozen_string_literal: true

module CoffeeApp
  module Errors
    class ParseError < StandardError
      attr_reader :original_error, :input

      def initialize(message, original_error: nil, input: nil)
        @original_error = original_error
        @input = input
        super(message)
      end
    end
  end
end
