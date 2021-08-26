# frozen_string_literal: true

module Timeline
  class RendererableEvent
    def initialize(event, renderer)
      @event = event
      @renderer = renderer
    end

    def attributes
      {
        x1: :x1,
        x2: :x2,
        y1: :y1,
        y2: :y2,
        stroke: :something
      }
    end
  end
end
