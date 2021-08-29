# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Lane do
  subject(:lane) { described_class.new(1) }

  let(:event) { create(10, 20) }

  it 'has a number' do
    expect(lane.number).to eq(1)
  end

  describe '#add_event' do
    it 'adds lane number to the event' do
      lane.add_event(event)

      expect(event.lane_number).to eq(1)
    end

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

    describe '#accept?' do
      it 'rejects when lane occupies event date range' do
        expect { lane.add_event(create(-455, 36)) }
          .to change { lane.accept?(create(406, 29)) }
          .from(true).to(false)
      end

      it 'does not accept an year that is in the middle of the range' do
        lane.add_event(create(-455, 36))

        expect(lane).not_to be_accept(create(-2, -2))
      end

      it 'does not a range if colides with single year event' do
        lane.add_event(create(29, 29))

        expect(lane).not_to be_accept(create(-455, 36))
      end

      it 'fix bug' do
        lane.add_event(create(-455, -406))
        lane.add_event(create(-406, 29))
        lane.add_event(create(-2, -2)) # should be rejected

        expect(lane.events.map(&:title)).to eq(['-455_-406', '-406_29'])
      end
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
