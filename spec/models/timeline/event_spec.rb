# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Event do
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

    it 'returns true when times times are within' do
      event = create(5, 10)

      expect(event).to be_overlap_with(create(9, 15))
      expect(event).to be_overlap_with(create(2, 6))
    end
  end

  def create(from, to)
    described_class.new(
      title: 'the title',
      time: Timeline::Time.new(
        from: Timeline::Year.new(from),
        to: Timeline::Year.new(to)
      ),
      explanation: 'the explanation'
    )
  end
end
