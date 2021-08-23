# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Year do
  describe '#to_s' do
    it 'returns localized year with era' do
      expect(described_class.new(-2).to_s).to eq('2 a.C.')
      expect(described_class.new(2).to_s).to eq('2 d.C.')
    end

    it 'includes precision when necessary' do
      expect(described_class.new(-2, precision: :after).to_s).to eq('d. 2 a.C.')
      expect(described_class.new(-2, precision: 'before').to_s).to eq('a. 2 a.C.')
      expect(described_class.new('-2', precision: 'about').to_s).to eq('c. 2 a.C.')
    end
  end

  it 'raises when precision is wrong' do
    expect do
      described_class.new(1, precision: 'yes')
    end.to raise_error(Timeline::Year::InvalidPrecision)
  end

  it 'raises when year is zero' do
    expect do
      described_class.new(0)
    end.to raise_error(Timeline::Year::InvalidYear)
  end

  it 'raises when year is zero' do
    expect do
      described_class.new('f')
    end.to raise_error(Timeline::Year::InvalidYear)
  end
end
