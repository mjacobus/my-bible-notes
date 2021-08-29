# frozen_string_literal: true

module Timeline
  class Event
    attr_reader :title, :time, :explanation, :color, :text

    delegate :single_year?, to: :time

    def initialize(args = {})
      @title = args.fetch(:title)
      @time = args.fetch(:time)
      @explanation = args.fetch(:explanation)
      @color = args[:color].presence
      @text = args[:text].presence
      @text_properties = args[:text_properties]
    end

    def overlap_with?(other, inclusive: true)
      time.overlap_with?(other.time, inclusive: inclusive)
    end

    def with_lane(lane)
      @lane = lane
      self
    end

    def lane_number
      @lane.number
    end

    def text_properties
      @text_properties.is_a?(Hash) ? @text_properties : JSON.parse(@text_properties.to_s)
    rescue JSON::ParserError
      {}
    end
  end
end
