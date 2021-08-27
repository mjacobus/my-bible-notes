# frozen_string_literal: true

module Timeline
  class Lane
    attr_reader :events
    attr_reader :number

    def initialize(number)
      @number = number
      @events = []
    end

    def add_event(event)
      if accept?(event)
        @events.push(event.with_lane(self))
      end
    end

    def accept?(candidate)
      !reject?(candidate)
    end

    private

    def reject?(candidate)
      events.any? do |event|
        if event.overlap_with?(candidate, inclusive: false)
          return true
        end
      end
    end
  end
end
