# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::Scripture, type: :model do
  subject(:scripture) { factory.build }

  let(:factory) { factories.scriptures }

  it { is_expected.to belong_to(:parent_scripture).class_name('Db::Scripture').optional }

  it 'has many related_scriptures' do
    expect(scripture).to have_many(:related_scriptures)
      .class_name('Db::Scripture')
      .dependent(:restrict_with_exception)
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:verses) }

  it 'validates chapters' do
    scripture.book = 'genesis'
    scripture.verses = '70:1'

    expect(scripture).not_to be_valid
    expect(scripture.errors[:verses]).to include('Capítulo não existe: 70')
  end

  it 'validates verses' do
    scripture.book = 'genesis'
    scripture.verses = '1:1; 2:87'

    expect(scripture).not_to be_valid
    expect(scripture.errors[:verses]).to include('Versículo não existe: 2:87')
  end

  describe '#to_s' do
    it 'converts the bible scripture to string' do
      scripture.book = 'genesis'
      scripture.verses = '2:1-3'

      expect(scripture.to_s).to eq('Gênesis 2:1-3')
    end

    it 'can be chagned' do
      scripture.book = 'genesis'
      scripture.verses = '2:1-3'

      expect { scripture.book = '1-peter' }.to change { scripture.to_s }
        .from('Gênesis 2:1-3').to('1 Pedro 2:1-3')
    end
  end

  it 'assigns a number to the book' do
    scripture.book = 'matthew'

    expect(scripture.book_number).to eq(40)
  end

  describe '.ordered' do
    it 'orders by book' do
      factory.create(book: 'matthew')
      factory.create(book: 'psalms')
      factory.create(book: 'genesis')
      factory.create(book: 'exodus')

      ordered = described_class.ordered

      expect(ordered.pluck(:book)).to eq(%w[genesis exodus psalms matthew])
    end
  end
end
