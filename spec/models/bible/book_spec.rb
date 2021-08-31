# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bible::Book, type: :model do
  subject(:book) { bible.first }

  let(:bible) { Bible::Factory.new.from_config }

  describe '#localized_name' do
    it 'returns the localized name' do
      expect(book.localized_name).to eq('Gênesis')

      bible.each do |book|
        expect(book.localized_name).not_to include('missing')
      end
    end
  end
end
