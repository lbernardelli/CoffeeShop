# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Services::Concerns::JsonParseable do
  # Create a test class that includes the concern
  let(:test_class) do
    Class.new do
      include CoffeeApp::Services::Concerns::JsonParseable

      def test_parse(json)
        parse_json(json)
      end

      def test_extract_user(data)
        extract_user_name(data)
      end
    end
  end

  let(:instance) { test_class.new }

  describe '#parse_json' do
    context 'with valid JSON' do
      it 'parses JSON and returns hash' do
        json = '[{"user":"alice","amount":10.00}]'
        result = instance.test_parse(json)

        expect(result).to be_an(Array)
        expect(result.first[:user]).to eq('alice')
        expect(result.first[:amount]).to eq(10.00)
      end
    end

    context 'with empty JSON' do
      it 'returns empty array' do
        result = instance.test_parse('')
        expect(result).to eq([])
      end
    end
  end

  describe '#extract_user_name' do
    it 'extracts user name from data hash' do
      data = { user: 'bob', amount: 5.00 }
      result = instance.test_extract_user(data)

      expect(result).to eq('bob')
    end
  end
end
