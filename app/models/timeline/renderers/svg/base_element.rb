# frozen_string_literal: true

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

        delegate :title, to: :event

        def explanation
          [event.time, event.explanation].join(': ')
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
                            y: y - 5,
                            fill: event.color,
                            'font-size': '10',
                            'font-family': 'Arial narrow'
                          })
        end

        def width
          event.time.length
        end

        def height
          helper.lane_height
        end

        def x1
          helper.years_map.position_for(event.time.from.to_i)
        end

        def y
          pt = helper.padding_top
          ls = helper.lane_spacing
          lane = event.lane_number

          pt + lane * (height + ls)
        end
      end
    end
  end
end
