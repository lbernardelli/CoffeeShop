# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::JsonParser do
  describe '.to_hash' do
    context 'with valid JSON' do
      let(:json) { '{"name":"John","age":30}' }

      it 'parses JSON with symbolized keys' do
        result = CoffeeApp::JsonParser.to_hash(json)
        expect(result).to eq({ name: 'John', age: 30 })
      end
    end

    context 'with valid JSON array' do
      let(:json) { '[{"id":1},{"id":2}]' }

      it 'parses JSON array' do
        result = CoffeeApp::JsonParser.to_hash(json)
        expect(result).to eq([{ id: 1 }, { id: 2 }])
      end
    end

    context 'with nil input' do
      it 'returns empty array' do
        result = CoffeeApp::JsonParser.to_hash(nil)
        expect(result).to eq([])
      end
    end

    context 'with empty string' do
      it 'returns empty array' do
        result = CoffeeApp::JsonParser.to_hash('')
        expect(result).to eq([])
      end
    end

    context 'with whitespace only' do
      it 'returns empty array' do
        result = CoffeeApp::JsonParser.to_hash('   ')
        expect(result).to eq([])
      end
    end

    context 'with invalid JSON' do
      let(:invalid_json) { '{invalid json}' }

      it 'raises ParseError' do
        expect { CoffeeApp::JsonParser.to_hash(invalid_json) }
          .to raise_error(CoffeeApp::Errors::ParseError, /Failed to parse JSON/)
      end

      it 'includes original error in ParseError' do
        begin
          CoffeeApp::JsonParser.to_hash(invalid_json)
        rescue CoffeeApp::Errors::ParseError => e
          expect(e.original_error).to be_a(JSON::ParserError)
          expect(e.input).to eq(invalid_json)
        end
      end
    end

    context 'with malformed JSON' do
      let(:malformed_json) { '{"name": John}' }

      it 'raises ParseError' do
        expect { CoffeeApp::JsonParser.to_hash(malformed_json) }
          .to raise_error(CoffeeApp::Errors::ParseError)
      end
    end
  end
end
