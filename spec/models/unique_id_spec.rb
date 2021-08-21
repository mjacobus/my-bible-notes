# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UniqueId do
  it 'when no id is given in the constructor creates a new unique id' do
    allow(SecureRandom).to receive(:uuid).and_return('foobar')

    expect(described_class.new.to_s).to eq 'foobar'
  end

  it 'when id is passed in the constructor uses that value as unique id' do
    string = described_class.new('foo').to_s

    expect(string).to eq 'foo'
  end

  # rubocop:disable RSpec/IdenticalEqualityAssertion
  it '#== returns true when values are the same' do
    expect(described_class.new('foo')).to eq described_class.new('foo')
  end
  # rubocop:enable RSpec/IdenticalEqualityAssertion

  it '#== returns false when values are different' do
    expect(described_class.new('bar')).not_to eq described_class.new('foo')
  end
end
