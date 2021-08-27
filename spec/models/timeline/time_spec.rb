# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Time do
  subject(:time) { create(10, 20) }

  describe '#single_year?' do
    it 'returns false when it is not a single year' do
      expect(time).not_to be_single_year
    end

    it 'returns true when it is a single year event' do
      time = create(10, 10)

      expect(time).to be_single_year
    end
  end

  specify '#cover_year? returns true depending on whether or not it covers year' do
    time = create(8, 10)

    expect(time).to be_cover_year(10, inclusive: true)
    expect(time).to be_cover_year(8, inclusive: true)

    expect(time).not_to be_cover_year(10, inclusive: false)
    expect(time).not_to be_cover_year(8, inclusive: false)

    expect(time).not_to be_cover_year(11, inclusive: true)
    expect(time).not_to be_cover_year(7, inclusive: true)
  end

  specify '#overlap_with? returns overlap boolean' do
    time = create(8, 10)

    expect(time).to be_overlap_with(create(5, 8), inclusive: true)
    expect(time).to be_overlap_with(create(10, 12), inclusive: true)

    expect(time).not_to be_overlap_with(create(5, 8), inclusive: false)
    expect(time).not_to be_overlap_with(create(10, 12), inclusive: false)

    expect(time).not_to be_overlap_with(create(1, 7), inclusive: true)
    expect(time).not_to be_overlap_with(create(11, 12), inclusive: true)

    expect(time).to be_overlap_with(create(5, 15))
  end

  it 'always overlaps when values are the same' do
    expect(time).to be_overlap_with(time, inclusive: true)
    expect(time).to be_overlap_with(time, inclusive: false)
    expect(time).to be_overlap_with(create(11, 20), inclusive: false)
    expect(time).to be_overlap_with(create(10, 19), inclusive: false)
  end

  it 'has a #length' do
    expect(create(1, 10).length).to eq(9)
    expect(create(-10, -1).length).to eq(9)
    expect(create(-10, 1).length).to eq(10)
    expect(create(-10, -5).length).to eq(5)
    expect(create(-455, 36).length).to eq(490)
  end

  it 'converts to string' do
    expect(create(-2, 2).to_s).to eq('2 a.C. - 2 d.C.')
    expect(create(2, 2).to_s).to eq('2 d.C.')
  end

  def create(from, to)
    described_class.new(from: Timeline::Year.new(from), to: Timeline::Year.new(to))
  end
end
