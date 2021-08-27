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

        def title
          event.title
        end

        def explanation
          event.explanation
        end

        def attributes
          {
            x: x1,
            y: y,
            width: width,
            height: height,
            fill: event.color,
            'fill-opacity': '0.7'
          }
        end

        def label
          TextElement.new(event.title, {
            x: x1 + 4,
            y: y + (height * 0.8).to_i,
            'font-size': '8'
          })
        end

        private

        attr_reader :event
        attr_reader :renderer

        def width
          event.time.length
        end

        def height
          20
        end

        def x1
          renderer.years_map[event.time.from.to_i]
        end

        def x2
          renderer.years_map[event.time.to.to_i] + 1
        end

        def y
          space = 0
          if event.lane_number.positive?
            space = 10
          end
          (event.lane_number * height) + space
        end
      end
    end
  end
end
