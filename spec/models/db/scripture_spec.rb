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

  it 'sorts related_scriptures by sequence_number' do
    scripture = factory.create
    factory.create(parent_id: scripture.id, book: 'mark', sequence_number: 2, title: 'two')
    factory.create(parent_id: scripture.id, book: 'genesis', sequence_number: 3, title: 'three')
    factory.create(parent_id: scripture.id, book: 'exodus', sequence_number: 1, title: 'one')

    expect(scripture.related_scriptures.map(&:title)).to eq(%w[one two three])
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
      factory.create(book: 'matthew', verses: '2:3')
      factory.create(book: 'psalms', verses: '22:3')
      factory.create(book: 'genesis')
      factory.create(book: 'exodus')

      ordered = described_class.ordered

      expect(ordered.pluck(:book)).to eq(%w[genesis exodus psalms matthew])
    end

    it 'orders also by verses' do
      factory.create(book: 'genesis', verses: '2:3')
      factory.create(book: 'psalms', verses: '22:3')
      factory.create(book: 'psalms', verses: '2:13')
      factory.create(book: 'psalms', verses: '21:2')

      ordered = described_class.ordered

      expect(ordered.pluck(:verses)).to eq(%w[2:3 2:13 21:2 22:3])
    end
  end

  it 'has many tags' do
    scripture.save!
    tag = factories.scripture_tags.create

    scripture.tag_ids = [tag.id]

    expect(scripture.reload.tags.map(&:name)).to include(tag.name)
  end

  describe '.search by tag' do
    it 'filters by tag slug' do
      tag = factories.scripture_tags.create
      other_tag = factories.scripture_tags.create
      s1 = factory.create(tag_ids: [tag.id])
      s2 = factory.create(tag_ids: [other_tag.id])
      _s3 = factory.create

      result = described_class.search(tags: "#{tag.slug},#{other_tag.slug}")

      expect(result.pluck(:title)).to eq([s1.title, s2.title])
    end
  end

  describe '.search by title' do
    it 'filters by title' do
      s1 = factory.create(title: 'Para Pedro Pedro para')
      s2 = factory.create(title: 'Este pedro é uma parada')
      _s3 = factory.create

      result = described_class.search(title: 'pedro')

      expect(result.pluck(:title)).to eq([s1.title, s2.title])
    end
  end

  describe '#first_chapter ' do
    it 'is set via #verses=' do
      scripture.verses = '10:3-10'

      expect { scripture.verses = '22:3-10' }.to change { scripture.first_chapter }.from(10).to(22)
    end
  end

  describe '#first_verse' do
    it 'is set via #verses=' do
      scripture.verses = '10:1-10'

      expect { scripture.verses = '22:3-10' }.to change { scripture.first_verse }.from(1).to(3)
    end
  end
end
