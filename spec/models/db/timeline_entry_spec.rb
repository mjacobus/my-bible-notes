# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::TimelineEntry, type: :model do
  subject(:entry) { factories.timeline_entries.build }

  it { is_expected.to belong_to(:timeline) }
  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to validate_presence_of(:from_year) }
  it { is_expected.to validate_presence_of(:from_precision) }

  it {
    expect(entry).to validate_inclusion_of(:from_precision).in_array(%w[precise about after
                                                                        before])
  }

  it { is_expected.to validate_presence_of(:to_year) }
  it { is_expected.to validate_presence_of(:to_precision) }

  it {
    expect(entry).to validate_inclusion_of(:to_precision).in_array(%w[precise about after before])
  }

  it 'does not permit zero as from_year' do
    entry.from_year = 0

    expect(entry).not_to be_valid
  end

  it 'does not permit from_year before -4050' do
    entry.from_year = -4051

    expect(entry).not_to be_valid
  end

  it 'does not from_year in the future' do
    entry.from_year = Time.zone.today.year + 1

    expect(entry).not_to be_valid
  end

  it 'has a valid factory' do
    expect(entry).to be_valid
  end

  it 'has an from_era' do
    entry.from_year = -1
    expect { entry.from_year = 1 }.to change(entry, :from_era).from('a.C.').to('d.C.')
  end

  it 'has a #formatted_from_year' do
    entry.from_year = -51

    expect(entry.formatted_from_year).to eq('51 a.C.')
  end

  it 'does not permit zero as to_year' do
    entry.to_year = 0

    expect(entry).not_to be_valid
  end

  it 'does not permit to_year before -4050' do
    entry.to_year = -4051

    expect(entry).not_to be_valid
  end

  it 'does not to_year in the future' do
    entry.to_year = Time.zone.today.year + 1

    expect(entry).not_to be_valid
  end

  it 'has an to_era' do
    entry.to_year = -1
    expect { entry.to_year = 1 }.to change(entry, :to_era).from('a.C.').to('d.C.')
  end

  it 'has a #formatted_to_year' do
    entry.to_year = -51

    expect(entry.formatted_to_year).to eq('51 a.C.')
  end

  specify '#confirmed is initially false' do
    expect(described_class.new.confirmed).to be false
  end
end
