# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/ExampleLength
RSpec.describe Timelines::TimelineComponent, type: :component do
  subject(:component) { described_class.new(timeline: timeline, entries: entries) }

  let(:timeline) { Db::Timeline.new(name: '70 week prophecy') }
  let(:entries) do
    [
      Db::TimelineEntry.new(title: '70 weeks', from_year: -455, to_year: 36, color: '70-weeks'),
      Db::TimelineEntry.new(title: '7 weeks', from_year: -455, to_year: -406, color: '7-weeks'),
      Db::TimelineEntry.new(title: '62 weeks', from_year: -406, to_year: 29, color: '62-weeks'),
      Db::TimelineEntry.new(title: '1 week', from_year: 29, to_year: 36, color: '1-week'),
      Db::TimelineEntry.new(title: 'Jesus Birth', from_year: -2, to_year: -2, color: 'jesus-birth')
    ]
  end

  it 'renders all expected events in 2 lanes' do
    render_inline(component)

    # Lane 1
    expect(rendered_component).to(have_css('rect[fill="70-weeks"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '60',
        y: '40',
        fill: '70-weeks',
        height: '4',
        width: '490'
      )
    end)

    # Lane 2
    expect(rendered_component).to(have_css('rect[fill="7-weeks"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '60',
        y: '64',
        fill: '7-weeks',
        height: '4',
        width: '49'
      )
    end)

    expect(rendered_component).to(have_css('rect[fill="62-weeks"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '109',
        y: '64',
        fill: '62-weeks',
        height: '4',
        width: '434'
      )
    end)

    expect(rendered_component).to(have_css('rect[fill="1-week"]') do |element|
      expect(attributes_for(element)).to eq(
        x: '543',
        y: '64',
        fill: '1-week',
        height: '4',
        width: '7'
      )
    end)

    expect(rendered_component).to(have_css('circle[fill="jesus-birth"]') do |element|
      expect(attributes_for(element)).to eq(
        cx: '513',
        cy: '88',
        r: '2',
        fill: 'jesus-birth'
      )
    end)
  end

  def attributes_for(simple)
    simple.native.attributes.map do |_key, element|
      [element.name, element.value]
    end.to_h.symbolize_keys.except(:'fill-opacity')
  end
end
# rubocop:enable RSpec/ExampleLength
