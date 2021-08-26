# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Renderers::Svg::Helper do
  subject(:helper) { described_class.new(timeline) }

  let(:timeline) do
    Timeline::Timeline.new(name: 'Test Timeline').tap do |t|
      entries.each do |entry|
        t.add_event(entry)
      end
    end
  end

  let(:entries) { [entry1, entry2, entry3, entry4] }
  let(:entry1) { create(-6, -4) }
  let(:entry2) { create(-3, 2) }
  let(:entry3) { create(3, 8) }
  let(:entry4) { create(7, 7) }

  def create(from, to)
    factories.timeline_events.create(from: from, to: to)
  end

  describe '#years_map' do
    it 'resolve #years_map' do
      helper.starting_at(-2).ending_at(2)

      expect(helper.years_map).to eq(
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
      let(:entry1) { create(-1, 2) }
      let(:entry2) { create(-2, 1) }

      it 'resolves' do
        expect(helper.years_map).to eq(
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
      helper.starting_at(-10).ending_at(10)
    end

    it 'properly returns #event_x1' do
      expect(helper.event_x1(entry1)).to eq 5
      expect(helper.event_x1(entry2)).to eq 8
      expect(helper.event_x1(entry3)).to eq 13
      expect(helper.event_x1(entry4)).to eq 17
    end

    it 'properly returns #event_x2' do
      expect(helper.event_x2(entry1)).to eq 7
      expect(helper.event_x2(entry2)).to eq 12
      expect(helper.event_x2(entry3)).to eq 18
    end

    it 'returns a 1 measure large x for single year entry' do
      expect(helper.event_x2(entry4)).to eq 18
    end

    it 'resolves #event_y' do
      helper.with_stroke_height(1).with_space_between_lines(2)

      expect(helper.event_y(entry1)).to eq(1)
    end

    it 'prepends half a stroke to the y position in #event_y' do
      helper.with_stroke_height(5).with_space_between_lines(1)

      expect(helper.event_y(entry1)).to eq(3)
    end

    it 'resolves #height' do
      helper.with_stroke_height(2).with_space_between_lines(1)

      expect(helper.height).to eq(13)
    end

    it 'resolves #width' do
      expect(helper.width).to eq(21)
    end
  end

  it 'resolves years divisions' do
    helper.with_years_interval(100).starting_at(-220).ending_at(220)

    expect(helper.years_to_display).to eq([-200, -100, 1, 100, 200])
    expect(helper.year_x(1)).to eq(221)
  end
end
