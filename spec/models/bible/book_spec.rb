# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bible::Book, type: :model do
  subject(:book) { bible.first }

  let(:bible) { Bible::Factory.new.from_config }
  let(:genesis) { bible.first }

  describe '#localized_name' do
    it 'returns the localized name' do
      expect(book.localized_name).to eq('Gênesis')

      bible.each do |book|
        expect(book.localized_name).not_to include('missing')
      end
    end
  end

  describe '#parse_parse' do
    it 'parses a single verse' do
      parsed = genesis.parse('1:2')

      expect(parsed).to eq(1 => [2])
    end
  end
end
