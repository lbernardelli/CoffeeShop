# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Support::SymbolKey do
  describe '.normalize' do
    context 'with string input' do
      it 'converts to symbol' do
        result = described_class.normalize('latte')
        expect(result).to eq(:latte)
      end

      it 'strips whitespace' do
        result = described_class.normalize('  latte  ')
        expect(result).to eq(:latte)
      end
    end

    context 'with symbol input' do
      it 'returns symbol' do
        result = described_class.normalize(:mocha)
        expect(result).to eq(:mocha)
      end
    end

    context 'with nil input' do
      it 'returns nil' do
        result = described_class.normalize(nil)
        expect(result).to be_nil
      end
    end

    context 'with numeric input' do
      it 'converts to symbol' do
        result = described_class.normalize(123)
        expect(result).to eq(:'123')
      end
    end
  end
end
