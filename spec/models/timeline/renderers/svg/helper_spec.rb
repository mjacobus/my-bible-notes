# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Renderers::Svg::Helper do
  subject(:helper) { described_class.new(timeline) }

  describe '#width' do
    it 'defaults to max length' do
      helper = create_helper([[-10, 5], [5, 10]])

      expect(helper.width).to eq(20)
    end
  end

  describe '#height' do
    it 'is number of lanes * height + spacing' do
      helper = create_helper([[10, 20], [10, 20]])
      helper.with_padding_top(10)
        .with_padding_bottom(4)
        .with_lane_height(5)
        .with_lane_spacing(2)

      expect(helper.height).to eq(10 + 5 + 2 + 5 + 2 + 4)
    end
  end

  describe '#years_map' do
    it 'gets resolved automatically' do
      helper = create_helper([[-1, 2], [-2, 1]])

      expect(helper.years_map.to_h).to eq(
        {
          -2 => 0,
          -1 => 1,
          1 => 2,
          2 => 3
        }
      )
    end
  end

  describe '#years_to_display' do
    it 'resolves years divisions' do
      helper = create_helper([])
      helper.with_years_interval(100).starting_at(-220).ending_at(220)

      expect(helper.years_to_display).to eq([-200, -100, 1, 100, 200])
    end
  end

  describe '#with_x_padding' do
    it 'adds padding to time range' do
      helper = create_helper([[-5, 10]]).with_x_padding(10)

      expect(helper.years_map.position_for(-15)).to eq(0)
      expect(helper.years_map.position_for(-5)).to eq(10)
      expect(helper.years_map.position_for(10)).to eq(24)
    end
  end

  def create_event(from, to)
    factories.timeline_events.create(from: from, to: to)
  end

  def create_helper(points)
    described_class.new(create_timeline(points))
  end

  def create_timeline(points)
    Timeline::Timeline.new(name: 'Test Timeline').tap do |t|
      points.each do |point|
        t.add_event(create_event(point.first, point.last))
      end
    end
  end
end
