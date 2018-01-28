# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::CoffeeVariant do
  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates variant successfully' do
        variant = CoffeeApp::CoffeeVariant.new(size: :small, price: 3.50)
        expect(variant.size).to eq(:small)
        expect(variant.price.to_f).to eq(3.50)
      end
    end

    context 'with nil size' do
      it 'raises ValidationError' do
        expect { CoffeeApp::CoffeeVariant.new(size: nil, price: 3.50) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Size cannot be empty')
      end
    end

    context 'with empty size' do
      it 'raises ValidationError' do
        expect { CoffeeApp::CoffeeVariant.new(size: '', price: 3.50) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Size cannot be empty')
      end
    end

    context 'with zero price' do
      it 'raises ValidationError' do
        expect { CoffeeApp::CoffeeVariant.new(size: :small, price: 0) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Price must be positive')
      end
    end

    context 'with negative price' do
      it 'raises ValidationError' do
        expect { CoffeeApp::CoffeeVariant.new(size: :small, price: -3.50) }
          .to raise_error(CoffeeApp::Errors::ValidationError, 'Price must be positive')
      end
    end
  end
end
