# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::ValueObjects::Money do
  describe '#initialize' do
    it 'creates money from integer' do
      money = CoffeeApp::ValueObjects::Money.new(10)
      expect(money.to_f).to eq(10.0)
    end

    it 'creates money from float' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money.to_f).to eq(10.50)
    end

    it 'creates money from string' do
      money = CoffeeApp::ValueObjects::Money.new('15.75')
      expect(money.to_f).to eq(15.75)
    end
  end

  describe '.zero' do
    it 'creates zero money' do
      money = CoffeeApp::ValueObjects::Money.zero
      expect(money.to_f).to eq(0.0)
    end
  end

  describe '#+ (addition)' do
    it 'adds two money amounts' do
      money1 = CoffeeApp::ValueObjects::Money.new(10.50)
      money2 = CoffeeApp::ValueObjects::Money.new(5.25)
      result = money1 + money2
      expect(result.to_f).to eq(15.75)
    end
  end

  describe '#- (subtraction)' do
    it 'subtracts two money amounts' do
      money1 = CoffeeApp::ValueObjects::Money.new(10.50)
      money2 = CoffeeApp::ValueObjects::Money.new(5.25)
      result = money1 - money2
      expect(result.to_f).to eq(5.25)
    end
  end

  describe '#* (multiplication)' do
    it 'multiplies money by a number' do
      money = CoffeeApp::ValueObjects::Money.new(10.00)
      result = money * 3
      expect(result.to_f).to eq(30.00)
    end
  end

  describe '#/ (division)' do
    it 'divides money by a number' do
      money = CoffeeApp::ValueObjects::Money.new(30.00)
      result = money / 3
      expect(result.to_f).to eq(10.00)
    end
  end

  describe '#==' do
    it 'returns true for equal amounts' do
      money1 = CoffeeApp::ValueObjects::Money.new(10.50)
      money2 = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money1 == money2).to be true
    end

    it 'returns false for different amounts' do
      money1 = CoffeeApp::ValueObjects::Money.new(10.50)
      money2 = CoffeeApp::ValueObjects::Money.new(5.25)
      expect(money1 == money2).to be false
    end

    it 'returns false when comparing to non-Money' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money == 10.50).to be false
    end
  end

  describe 'Comparable' do
    it 'compares money amounts with >' do
      money1 = CoffeeApp::ValueObjects::Money.new(10.50)
      money2 = CoffeeApp::ValueObjects::Money.new(5.25)
      expect(money1 > money2).to be true
    end

    it 'compares money amounts with <' do
      money1 = CoffeeApp::ValueObjects::Money.new(5.25)
      money2 = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money1 < money2).to be true
    end
  end

  describe '#zero?' do
    it 'returns true for zero amount' do
      money = CoffeeApp::ValueObjects::Money.zero
      expect(money.zero?).to be true
    end

    it 'returns false for non-zero amount' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money.zero?).to be false
    end
  end

  describe '#positive?' do
    it 'returns true for positive amount' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money.positive?).to be true
    end

    it 'returns false for zero amount' do
      money = CoffeeApp::ValueObjects::Money.zero
      expect(money.positive?).to be false
    end
  end

  describe '#negative?' do
    it 'returns true for negative amount' do
      money = CoffeeApp::ValueObjects::Money.new(-10.50)
      expect(money.negative?).to be true
    end

    it 'returns false for positive amount' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money.negative?).to be false
    end
  end

  describe '#to_f' do
    it 'converts to float' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money.to_f).to eq(10.50)
    end
  end

  describe '#to_s' do
    it 'converts to string' do
      money = CoffeeApp::ValueObjects::Money.new(10.50)
      expect(money.to_s).to match(/10\.5/)
    end
  end
end
