# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bible::VersesParser, type: :model do
  subject(:parser) { described_class.new(verses) }

  let(:verses) do
    {
      1 => 10,
      2 => 20,
      3 => 30
    }
  end

  describe '#parse' do
    it 'parses a single verse' do
      parsed = parser.parse('1:2')

      expect(parsed).to eq(1 => [2])
    end

    it 'parses a multiple verses' do
      parsed = parser.parse('1:2,10')

      expect(parsed).to eq(1 => [2, 10])
    end

    it 'parses a sequence verses' do
      parsed = parser.parse('1:2-10')

      expect(parsed).to eq(1 => (2..10).to_a)
    end

    it 'parses multiple chapters and verses' do
      parsed = parser.parse('1:2-4, 12; 2:17,19')

      expected = {
        1 => [2, 3, 4, 12],
        2 => [17, 19]
      }

      expect(parsed).to eq(expected)
    end

    it 'parses one entire chapter' do
      parsed = parser.parse('2')

      expected = { 2 => (1..20).to_a }

      expect(parsed).to eq(expected)
    end

    it 'parses multiple verses I.E. (2-4)'
    it 'parses chapter-verse ranges I.E. (2:40-4:23)'

    context 'when book has one chapter' do
      let(:verses) { { 1 => 10 } }

      it 'parses single verses for 1 chapter books' do
        parsed = parser.parse('3')

        expected = { 1 => [3] }

        expect(parsed).to eq(expected)
      end

      it 'parses multiple verses with ranges for 1 chapter books' do
        parsed = parser.parse('2,4-6,8')

        expected = { 1 => [2, 4, 5, 6, 8] }

        expect(parsed).to eq(expected)
      end
    end
  end
end
