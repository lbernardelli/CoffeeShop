# frozen_string_literal: true

require 'spec_helper'
RSpec.describe CoffeeFactory do
  subject { CoffeeFactory.new(prices_json).build }

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
      expect(subject[0].name).to eq('short espresso')
      expect(subject[0].sizes.size).to be 1
      expect(subject[0].sizes[0]).eql?(CoffeeVariant.new(size: :small, price: 3.03))
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
      expect(subject[0].name).to eq('short espresso')
      expect(subject[0].sizes.size).to be 1
      expect(subject[0].sizes[0]).eql?(CoffeeVariant.new(size: :small, price: 3.03))

      expect(subject[1].name).to eq('long black')
      expect(subject[1].sizes.size).to be 2
      expect(subject[1].sizes[0]).eql?(CoffeeVariant.new(size: :small, price: 3.25))
      expect(subject[1].sizes[1]).eql?(CoffeeVariant.new(size: :medium, price: 3.50))
    end
  end
end
