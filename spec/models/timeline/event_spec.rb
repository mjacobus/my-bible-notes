# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeline::Event, type: :model do
  subject(:event) { create(10, 20) }

  it 'has a title' do
    expect(event.title).to eq('the title')
  end

  it 'has a color' do
    expect(event.color).to include('color-')
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
      expect(create(-455, 36)).to be_overlap_with(create(-406, 29), inclusive: true)
      expect(create(-455, 36)).to be_overlap_with(create(-406, 29), inclusive: false)
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

  describe '#text_properties' do
    it 'returns empty hash when properties are nil' do
      event = create(10, 10, text_properties: '')

      expect(event.text_properties).to eq({})
    end

    it 'returns a hash when content is a hash' do
      event = create(10, 10, text_properties: { 'foo' => 'bar' })

      expect(event.text_properties).to eq({ 'foo' => 'bar' })
    end

    it 'returns a hash when content is a json string' do
      event = create(10, 10, text_properties: { 'foo' => 'bar' }.to_json)

      expect(event.text_properties).to eq({ 'foo' => 'bar' })
    end
  end

  def create(from, to, other_attributes = {})
    factories.timeline_events.create(
      {
        title: 'the title',
        from: from,
        to: to,
        explanation: 'the explanation'
      }.merge(other_attributes)
    )
  end
end
