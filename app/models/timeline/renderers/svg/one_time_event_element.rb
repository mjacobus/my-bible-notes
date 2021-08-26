# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class OneTimeEventElement
        def initialize(event, renderer)
          @event = event
          @renderer = renderer
        end

        def tag
          :rect
        end

        def attributes
          {
            x: x1,
            y: y,
            width: width,
            height: height,
            fill: event.color,
          }
        end

        private

        attr_reader :event
        attr_reader :renderer

        def width
          event.time.length
        end

        def height
          50
        end


        def x1
          renderer.years_map[event.time.from.to_i]
        end

        def x2
          renderer.years_map[event.time.to.to_i] + 1
        end

        def y
          (event.lane_number * height)
        end
      end
    end
  end
end
