# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Event, type: :model do
  subject(:event) { create(10, 20) }

  it 'has a title' do
    expect(event.title).to eq('the title')
  end

  it 'has a time' do
    expect(event.time.from.to_i).to be 10
    expect(event.time.to.to_i).to be 20
  end

  it 'has an explanation' do
    expect(event.explanation).to eq 'the explanation'
  end

  describe '#overlap_with?' do
    it 'returns false when times are totally different' do
      event = create(5, 10)

      expect(event).not_to be_overlap_with(create(11, 12))
      expect(event).not_to be_overlap_with(create(1, 4))
    end

    it 'returns true when numbers are at the edge and cover is inclusive' do
      event = create(5, 10)

      expect(event).to be_overlap_with(create(10, 11), inclusive: true)
      expect(event).to be_overlap_with(create(2, 5), inclusive: true)
    end

    it 'returns false when numbers are at the edge and cover is not inclusive' do
      event = create(5, 10)

      expect(event).not_to be_overlap_with(create(10, 11), inclusive: false)
      expect(event).not_to be_overlap_with(create(2, 5), inclusive: false)
    end

    it 'returns true when times times are within' do
      event = create(5, 10)

      expect(event).to be_overlap_with(create(9, 15))
      expect(event).to be_overlap_with(create(2, 6))
    end
  end

  def create(from, to)
    factories.timeline_events.create(
      title: 'the title',
      from: from,
      to: to,
      explanation: 'the explanation'
    )
  end
end