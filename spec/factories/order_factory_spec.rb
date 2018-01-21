require 'spec_helper'
RSpec.describe OrderFactory do

  subject { OrderFactory.new(orders_json).build }

  context 'Build a empty order description' do
    let(:orders_json) { '' }

    it('An empty list') { is_expected.to be_empty }
  end

  context 'Build one order' do
    let(:orders_json) do
      <<-JSON
      [
        { "user": "coach", "drink": "flat white", "size": "large" }
      ]
      JSON
    end

    it ('A list with one order') { expect(subject.size).to be 1 }
    it 'The built order' do
      expect(subject[0].user.name).to eq('coach')
      expect(subject[0].coffee_name).to eq('flat white')
      expect(subject[0].coffee_size).to eq(:large)
    end
  end

  context 'Build two orders' do
    let(:orders_json) do
      <<-JSON
      [
        { "user": "coach", "drink": "long black", "size": "medium" },
        { "user": "ellis", "drink": "long black", "size": "small" }
      ]
      JSON
    end

    it('A list containing 2 orders') { expect(subject.size).to be 2 }
    it 'A bunch of orders' do
      expect(subject[0].user.name).to eq('coach')
      expect(subject[0].coffee_name).to eq('long black')
      expect(subject[0].coffee_size).to eq(:medium)

      expect(subject[1].user.name).to eq('ellis')
      expect(subject[1].coffee_name).to eq('long black')
      expect(subject[1].coffee_size).to eq(:small)
    end
  end
end