module Timeline
  module Renderers
    module Svg
      class BaseElement
        attr_reader :event
        attr_reader :helper

        def initialize(event, renderer_helper)
          @event = event
          @helper = renderer_helper
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



        def width
          event.time.length
        end

        def height
          20
        end

        def x1
          helper.years_map[event.time.from.to_i]
        end

        def y
          space = 0
          if event.lane_number.positive?
            space = 10
          end
          (event.lane_number * height) + space + helper.padding_top
        end
      end
    end
  end
end
