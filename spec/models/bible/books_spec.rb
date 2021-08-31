# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bible::Books, type: :model do
  subject(:bible) { Bible::Factory.new.from_config }

  it 'finds by number' do
    book = bible.find('40')

    expect(book.name).to eq('Matthew')
  end

  it 'finds by slug' do
    book = bible.find('matthew')

    expect(book.name).to eq('Matthew')
  end
end
