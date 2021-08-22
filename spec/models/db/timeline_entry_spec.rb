# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Db::TimelineEntry, type: :model do
  let(:entry) { factories.timeline_entries.build }

  it { is_expected.to belong_to(:timeline) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:precision) }
  it { is_expected.to validate_inclusion_of(:precision).in_array(%w[precise about after before]) }
  it { is_expected.to validate_presence_of(:confirmed) }

  it 'does not permit zero as year' do
    entry.year = 0

    expect(entry).not_to be_valid
  end

  it 'does not permit zero as year' do
    entry.year = -4051

    expect(entry).not_to be_valid
  end

  it 'does not year in the future' do
    entry.year = Time.zone.today.year + 1

    expect(entry).not_to be_valid
  end

  it 'has a valid factory' do
    expect(entry).to be_valid
  end

  it 'has an era' do
    entry.year = -1
    expect { entry.year = 1 }.to change(entry, :era).from('a.C.').to('d.C.')
  end
end
