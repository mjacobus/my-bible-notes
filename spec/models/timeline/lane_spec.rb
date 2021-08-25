# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Lane do
  subject(:lane) { described_class.new }

  let(:event) { create(10, 20) }

  describe '#add_event' do
    it 'accepts when there are no overlaps' do
      expect(lane.add_event(event)).to be_truthy
      expect(lane.add_event(event)).to be_falsy

      expect(lane.events.map(&:title)).to eq(['10_20'])
    end

    it 'accepts two or sequences' do
      event2 = create(20, 30)
      event3 = create(40, 50)

      lane.add_event(event)
      lane.add_event(event2)
      lane.add_event(event3)

      expect(lane.events).to eq([event, event2, event3])
    end

    it 'only accepts 1 year events that won\'t colide' do
      event2 = create(10, 10)
      event3 = create(20, 20)

      lane.add_event(event)
      lane.add_event(event2)
      lane.add_event(event3)

      expect(lane.events.map(&:title)).to eq(%w[10_20 20_20])
    end

    it "accepts events that won't colide with existing 1 year events" do
      event = create(10, 10)
      event2 = create(10, 20)
      event3 = create(5, 10)

      lane.add_event(event)
      lane.add_event(event2)
      lane.add_event(event3)

      expect(lane.events.map(&:title)).to eq(%w[10_10 5_10])
    end
  end

  def create(from, to)
    factories.timeline_events.create(
      from: from,
      to: to,
      explanation: 'the explanation'
    )
  end
end
