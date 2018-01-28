# frozen_string_literal: true

module CoffeeApp
  module Support
    module SymbolKey
      module_function

      def normalize(value)
        return nil if value.nil?

        value.to_s.strip.to_sym
      end
    end
  end
end
