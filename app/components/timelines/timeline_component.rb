# frozen_string_literal: true

class Timelines::TimelineComponent < ApplicationComponent
  has :timeline
  has :entries
  attr_reader :helper

  def initialize(timeline:, entries:)
    super(timeline: timeline, entries: entries)

    timeline = Timeline::Timeline.new(name: timeline.name)

    entries.each do |entry|
      timeline.add_event(create_event(entry))
    end

    @helper = Timeline::Renderers::Svg::Helper.new(timeline).with_x_padding(60)
  end

  def render?
    entries.any?
  end

  private

  def create_event(entry)
    from = Timeline::Year.new(entry.from_year, precision: entry.from_precision)
    to = Timeline::Year.new(entry.to_year, precision: entry.to_precision)

    Timeline::Event.new(
      title: entry.title,
      time: Timeline::Time.new(from: from, to: to),
      explanation: entry.explanation,
      color: entry.color
    )
  end
end
