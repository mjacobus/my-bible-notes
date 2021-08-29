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
        if candidate.single_year? || event.single_year?
          next reject_by_single_year?(candidate, event)
        end

        if candidate.overlap_with?(event, inclusive: false)
          next true
        end
      end
    end

    def reject_by_single_year?(candidate, event)
      if candidate.single_year?
        return single_year_overlap?(candidate, event)
      end

      single_year_overlap?(event, candidate)
    end

    def single_year_overlap?(event, other)
      if event.time.to.to_i == other.time.from.to_i
        return true
      end

      other.time.cover_year?(event.time.from)
    end
  end
end
