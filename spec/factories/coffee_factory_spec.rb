# frozen_string_literal: true

require 'spec_helper'
RSpec.describe CoffeeApp::CoffeeFactory do
  subject { CoffeeApp::CoffeeFactory.new(prices_json).build }

  context 'Build a empty coffee description' do
    let(:prices_json) { '' }

    it('An empty list') { is_expected.to be_empty }
  end

  context 'Build one coffee' do
    let(:prices_json) do
      <<-JSON
      [
        { "drink_name": "short espresso", "prices": { "small": 3.03 } }
      ]
      JSON
    end

    it ('A list with one coffee') { expect(subject.size).to be 1 }
    it 'The built coffee' do
      expect(subject[:'short espresso'].name).to eq('short espresso')
      expect(subject[:'short espresso'].sizes.size).to be 1
      expect(subject[:'short espresso'].sizes[0]).eql?(CoffeeApp::CoffeeVariant.new(size: :small, price: 3.03))
    end
  end

  context 'Build two coffees' do
    let(:prices_json) do
      <<-JSON
      [
        { "drink_name": "short espresso", "prices": { "small": 3.03 } },
        { "drink_name": "long black", "prices": { "small": 3.25, "medium": 3.50 } }
      ]
      JSON
    end

    it('A list containing 2 coffees') { expect(subject.size).to be 2 }
    it 'A bunch of coffees' do
      expect(subject[:'short espresso'].name).to eq('short espresso')
      expect(subject[:'short espresso'].sizes.size).to be 1
      expect(subject[:'short espresso'].sizes[0]).eql?(CoffeeApp::CoffeeVariant.new(size: :small, price: 3.03))

      expect(subject[:'long black'].name).to eq('long black')
      expect(subject[:'long black'].sizes.size).to be 2
      expect(subject[:'long black'].sizes[0]).eql?(CoffeeApp::CoffeeVariant.new(size: :small, price: 3.25))
      expect(subject[:'long black'].sizes[1]).eql?(CoffeeApp::CoffeeVariant.new(size: :medium, price: 3.50))
    end
  end
end
