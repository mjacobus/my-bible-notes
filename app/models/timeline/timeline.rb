# frozen_string_literal: true

module Timeline
  class Timeline
    attr_reader :name
    attr_reader :lanes

    def initialize(attributes = {})
      @name = attributes.fetch(:name)
      @lanes = []
    end

    def add_event(event)
      lanes.each do |lane|
        if lane.add_event(event)
          # rubocop:disable Lint/NonLocalExitFromIterator
          return
          # rubocop:enable Lint/NonLocalExitFromIterator
        end
      end

      create_lane(event)
    end

    def events
      lanes.map(&:events).flatten
    end

    private

    def create_lane(event)
      lane = Lane.new(lanes.length)
      lane.add_event(event)
      @lanes.push(lane)
    end
  end
end
