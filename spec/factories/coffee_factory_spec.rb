require 'spec_helper'
RSpec.describe CoffeeFactory do

  context 'Build one coffee' do
    let(:prices_json) {
      <<-JSON
      [
        { "drink_name": "short espresso", "prices": { "small": 3.03 } }
      ]
      JSON
    }

    subject { CoffeeFactory.new(prices_json).build }

    it 'A list with one coffee' do
      expect(subject[0].name).to eq('short espresso')
      expect(subject[0].sizes.size).to be 1
      expect(subject[0].sizes[0]).eql?(CoffeeSize.new({size: :small, price: 3.03}))
    end
  end
end