# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Timeline, type: :mocel do
  subject(:timeline) { described_class.new(name: 'The title') }

  it 'has a name' do
    expect(timeline.name).to eq('The title')
  end

  it 'creates lanes according to the needs' do
    timeline.add_event(create(10, 20))
    timeline.add_event(create(9, 12))
    timeline.add_event(create(20, 20))

    collected = timeline.lanes.map { |lane| lane.events.map(&:title) }

    expect(collected).to eq([
      %w[10_20 20_20],
      ['9_12']
    ])
  end

  def create(from, to)
    factories.timeline_events.create({ from: from, to: to })
  end
end
