# frozen_string_literal: true

module CoffeeApp
  module Services
    module Concerns
      module JsonParseable
        private

        def parse_json(json)
          CoffeeApp::JsonParser.to_hash(json)
        end

        def extract_user_name(data)
          data[:user]
        end
      end
    end
  end
end
