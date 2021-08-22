# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::Timeline, type: :model do
  subject(:timeline) { factories.timelines.build }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_uniqueness_of(:slug).case_insensitive.scoped_to(:user_id) }

  it 'is initially not public' do
    expect(timeline).not_to be_public
  end

  it 'parameterizes slug' do
    timeline.slug = 'Um dois três'

    expect(timeline.slug).to eq('um-dois-tres')
  end

  it 'has a valid test factory' do
    valid = timeline.valid?

    expect(timeline.errors).to be_empty
    expect(valid).to be true
  end

  describe '#find_by_slug' do
    it 'raises error when not found' do
      expect { described_class.find_by_slug('noope') }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'finds by slug' do
      timeline.save

      found = described_class.find_by_slug(timeline.slug)

      expect(found.id).to eq(timeline.id)
    end
  end
end
