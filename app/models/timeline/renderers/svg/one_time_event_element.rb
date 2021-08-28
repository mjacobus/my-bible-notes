# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class OneTimeEventElement < BaseElement
        def tag
          :circle
        end

        def attributes
          {
            r: height / 2,
            cx: center,
            cy: y,
            fill: event.color
          }
        end

        def center
          helper.years_map.position_for(event.time.from.to_i)
        end
      end
    end
  end
end
