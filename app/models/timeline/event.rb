# frozen_string_literal: true

module Timeline
  class Event
    attr_reader :title, :time, :explanation

    delegate :single_year?, to: :time

    def initialize(args = {})
      @title = args.fetch(:title)
      @time = args.fetch(:time)
      @explanation = args.fetch(:explanation)
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
  end
end
