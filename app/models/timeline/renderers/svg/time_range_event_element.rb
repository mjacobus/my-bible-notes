# frozen_string_literal: true

# <rect x="10" y="10" width="30" height="30" 
# stroke="black" fill="transparent" stroke-width="5"/>
module Timeline
  module Renderers
    module Svg
      class TimeRangeEventElement < OneTimeEventElement
        private

        # @overrides
        def x2
          renderer.years_map[event.time.to.to_i]
        end
      end
    end
  end
end
