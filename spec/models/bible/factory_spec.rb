# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bible::Factory, type: :model do
  subject(:factory) { described_class.new }

  let(:bible) { described_class.new.from_config }

  it 'returns an instance of the bible with 66 books' do
    expect(bible).to be_a(Bible::Books)
    expect(bible.size).to eq(66)

    genesis = bible.first

    expect(genesis.name).to eq('Genesis')
    expect(genesis.slug).to eq('genesis')
    expect(genesis.chapters).to eq(50)
    expect(genesis.verses[44]).to eq(34)
    expect(genesis.number).to eq(1)
  end
end
