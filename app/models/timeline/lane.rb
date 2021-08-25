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
        return @events.push(event.with_lane(self))
      end
    end

    def accept?(candidate)
      !reject?(candidate)
    end

    private

    def reject?(candidate)
      events.any? do |event|
        if candidate.overlap_with?(event, inclusive: false)
          return true
        end

        reject_by_single_year?(candidate, event)
      end
    end

    def reject_by_single_year?(candidate, event)
      if candidate.single_year? && (candidate.time.to.to_i == event.time.from.to_i)
        return true
      end

      event.single_year? && (event.time.to.to_i == candidate.time.from.to_i)
    end
  end
end
