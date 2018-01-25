# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoffeeApp::Repositories::UserRepository do
  let(:repository) { CoffeeApp::Repositories::UserRepository.new }

  describe '#find_or_create' do
    context 'when user does not exist' do
      it 'creates a new user' do
        user = repository.find_or_create('Alice')
        expect(user).to be_a(CoffeeApp::User)
        expect(user.name).to eq('Alice')
      end

      it 'stores the user in repository' do
        user = repository.find_or_create('Alice')
        expect(repository.all[:Alice]).to eq(user)
      end
    end

    context 'when user already exists' do
      it 'returns the existing user' do
        user1 = repository.find_or_create('Bob')
        user2 = repository.find_or_create('Bob')
        expect(user1).to eq(user2)
      end
    end
  end

  describe '#save' do
    it 'saves a user to the repository' do
      user = CoffeeApp::User.new(name: 'Charlie')
      repository.save(user)
      expect(repository.all[:Charlie]).to eq(user)
    end

    it 'updates an existing user' do
      user = repository.find_or_create('Dave')
      user.pay(10.00)
      repository.save(user)
      expect(repository.all[:Dave].total_paid).to eq(BigDecimal.new('10.00'))
    end
  end

  describe '#all' do
    it 'returns empty hash when no users' do
      expect(repository.all).to eq({})
    end

    it 'returns all users' do
      user1 = repository.find_or_create('Eve')
      user2 = repository.find_or_create('Frank')

      all_users = repository.all
      expect(all_users.size).to eq(2)
      expect(all_users[:Eve]).to eq(user1)
      expect(all_users[:Frank]).to eq(user2)
    end
  end
end
