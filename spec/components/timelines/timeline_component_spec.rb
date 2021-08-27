# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timelines::TimelineComponent, type: :component do
  subject(:component) { described_class.new(timeline: timeline, entries: entries) }

  let(:timeline) { Db::Timeline.new(name: '70 week prophecy') }
  let(:entries) do
    [
      Db::TimelineEntry.new(title: '70 weeks', from_year: -455, to_year: 36, color: '70-weeks'),
      Db::TimelineEntry.new(title: '7 weeks', from_year: -455, to_year: -406, color: '7-weeks'),
      Db::TimelineEntry.new(title: '62 weeks', from_year: -406, to_year: 29, color: '62-weeks'),
      Db::TimelineEntry.new(title: '1 week', from_year: 29, to_year: 36, color: '1-week')
    ]
  end

  it 'renders all expected events in 2 lanes' do
    page = render_inline(component)

    # Lane 1
    expect(rendered_component).to(have_css('rect[fill="70-weeks"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '0',
        y: '0',
        fill: '70-weeks',
        height: '20',
        width: '490'
      )
    end)

    # Lane 2
    expect(rendered_component).to(have_css('rect[fill="7-weeks"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '0',
        y: '30',
        fill: '7-weeks',
        height: '20',
        width: '49'
      )
    end)

    expect(rendered_component).to(have_css('rect[fill="62-weeks"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '49',
        y: '30',
        fill: '62-weeks',
        height: '20',
        width: '434'
      )
    end)

    expect(rendered_component).to(have_css('rect[fill="1-week"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '483',
        y: '30',
        fill: '1-week',
        height: '20',
        width: '7'
      )
    end)
  end

  def attributes_for(simple)
    simple.native.attributes.map do |_key, element|
      [element.name, element.value]
    end.to_h.symbolize_keys.except(:'fill-opacity')
  end
end
