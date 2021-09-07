# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScriptureFinder do
  subject(:finder) { described_class.new(user) }

  let(:factory) { factories.scriptures }
  let(:user) { factories.users.create }

  describe '.search by tag' do
    it 'filters by tag slug' do
      tag = factories.scripture_tags.create()
      other_tag = factories.scripture_tags.create
      s1 = factory.create(tag_ids: [tag.id])
      s2 = factory.create(tag_ids: [other_tag.id])
      _s3 = factory.create

      result = finder.search(tags: "#{tag.slug},#{other_tag.slug}")

      expect(result.pluck(:title).sort).to eq([s1.title, s2.title].sort)
    end
  end

  describe '.search by title' do
    it 'filters by title' do
      s1 = factory.create(title: 'Para Pedro Pedro para')
      s2 = factory.create(title: 'Este pedro é uma parada')
      _s3 = factory.create

      result = finder.search(title: 'pedro')

      expect(result.pluck(:title).sort).to eq([s1.title, s2.title].sort)
    end
  end
end
