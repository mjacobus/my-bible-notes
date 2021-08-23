# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers:
RSpec.describe Timelines::TimelineComponent, type: :component do
  subject(:component) { described_class.new(timeline: timeline, entries: entries) }

  let(:entries) { [entry1, entry2, entry3, entry4] }
  let(:timeline) { Db::Timeline.new }
  let(:entry1) { Db::TimelineEntry.new(from_year: -6, to_year: -4) }
  let(:entry2) { Db::TimelineEntry.new(from_year: -3, to_year: 2) }
  let(:entry3) { Db::TimelineEntry.new(from_year: 3, to_year: 8) }
  let(:entry4) { Db::TimelineEntry.new(from_year: 7, to_year: 7) }

  describe '#years_map' do
    it 'resolve #years_map' do
      component.starting_at(-2).ending_at(2)

      expect(component.years_map).to eq(
        {
          -2 => 1,
          -1 => 2,
          1 => 3,
          2 => 4
        }
      )
    end

    context 'when automatically defining' do
      let(:entries) { [entry1, entry2] }
      let(:entry1) { Db::TimelineEntry.new(from_year: -1, to_year: 2) }
      let(:entry2) { Db::TimelineEntry.new(from_year: -2, to_year: 1) }

      it 'resolves' do
        expect(component.years_map).to eq(
          {
            -2 => 1,
            -1 => 2,
            1 => 3,
            2 => 4
          }
        )
      end
    end
  end

  describe 'Xs and Ys' do
    before do
      component.starting_at(-10).ending_at(10)
    end

    it 'properly returns #entry_x1' do
      expect(component.entry_x1(entry1)).to eq 5
      expect(component.entry_x1(entry2)).to eq 8
      expect(component.entry_x1(entry3)).to eq 13
      expect(component.entry_x1(entry4)).to eq 17
    end

    it 'properly returns #entry_x2' do
      expect(component.entry_x2(entry1)).to eq 7
      expect(component.entry_x2(entry2)).to eq 12
      expect(component.entry_x2(entry3)).to eq 18
    end

    it 'returns a 1 measure large x for single year entry' do
      expect(component.entry_x2(entry4)).to eq 18
    end

    it 'resolves #entry_y' do
      component.with_stroke_width(1).with_space_between_lines(2)

      expect(component.entry_y(entry1)).to eq(1)
      expect(component.entry_y(entry2)).to eq(4)
      expect(component.entry_y(entry3)).to eq(7)
      expect(component.entry_y(entry4)).to eq(10)
    end

    it 'prepends half a stroke to the y position in #entry_y' do
      component.with_stroke_width(5).with_space_between_lines(1)

      expect(component.entry_y(entry1)).to eq(3)
      expect(component.entry_y(entry2)).to eq(9)
      expect(component.entry_y(entry3)).to eq(15)
      expect(component.entry_y(entry4)).to eq(21)
    end

    it 'resolves #height' do
      component.with_stroke_width(2).with_space_between_lines(1)

      expect(component.height).to eq(13)
    end

    it 'resolves #width' do
      expect(component.width).to eq(21)
    end
  end

  it 'resolves years divisions' do
    component.with_years_interval(100).starting_at(-220).ending_at(220)

    expect(component.years_to_display).to eq([-200, -100, 1, 100, 200])
    expect(component.year_x(1)).to eq(221)
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers:
