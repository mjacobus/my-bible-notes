# frozen_string_literal: true

module Timeline
  class Event
    attr_reader :title, :time, :explanation

    def initialize(args = {})
      @title = args.fetch(:title)
      @time = args.fetch(:time)
      @explanation = args.fetch(:explanation)
    end

    def overlap_with?(other, inclusive: false)
      time.overlap_with?(other.time, inclusive: inclusive)
    end
  end
end
