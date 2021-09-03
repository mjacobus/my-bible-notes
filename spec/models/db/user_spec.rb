# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::User, type: :model do
  subject(:user) { factory.build }

  let(:factory) { factories.users }

  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:timelines).dependent(:destroy) }
  it { is_expected.to have_many(:scriptures).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }

  it 'parameterizes username' do
    user.username = 'Coração'

    expect(user.username).to eq('coracao')
  end

  describe '#permissions' do
    it 'is initially an empty hash' do
      user.permissions_config = ''

      expect(user.permissions).to eq('controllers' => [])
    end

    it 'returns a hash containing the configuration' do
      user.permissions_config = '{"foo":"bar"}'

      expect(user.permissions).to eq({ 'controllers' => [], 'foo' => 'bar' })
    end

    it 'can be retrieved after persistency' do
      user.permissions_config = '{"foo":"bar"}'
      user.save!

      expect(user.permissions).to eq({ 'controllers' => [], 'foo' => 'bar' })
    end

    it 'can be assigned by #add_permission' do
      user.grant_controller_access('foo')
      user.grant_controller_access('bar', action: 'index')
      user.save!

      expected = { 'controllers' => ['foo#*', 'bar#index'] }

      expect(user.permissions).to eq(expected)
      expect(user.reload.permissions).to eq(expected)
    end
  end

  describe '#controller_accesses' do
    it 'can be assigned by #controller_accesses=' do
      user.controller_accesses = (['foo#bar'])
      user.controller_accesses = (['foo#bar', '#'])
      user.save!

      expected = { 'controllers' => ['foo#bar'] }

      expect(user.permissions).to eq(expected)
      expect(user.reload.permissions).to eq(expected)
      expect(user.controller_accesses).to eq(['foo#bar'])
    end
  end

  describe '#timelines' do
    it 'returns the timeline scope' do
      user.save
      user.timelines.create(factories.timelines.attributes.except(:user_id))
    end
  end
end
