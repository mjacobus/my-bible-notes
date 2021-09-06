# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NameBasedColor, type: :model do
  subject(:color) { described_class.new('John Doe') }

  describe '#rgb_values' do
    it 'returns rgb values' do
      color = described_class.new('abcd')

      expected = [
        ('a'.ord + 'd'.ord) % 255,
        'b'.ord % 255,
        'c'.ord % 255
      ]
      expect(color.rgb_values).to eq(expected)
    end
  end

  it 'returns a color code when calling #to_s' do
    expect(described_class.new('John Doe').to_s).to eq('#28f4ac')
    expect(described_class.new('xyz').to_s).not_to eq(color.to_s)
  end
end
