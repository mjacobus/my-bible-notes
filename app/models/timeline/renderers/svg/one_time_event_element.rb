# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class OneTimeEventElement < BaseElement

        # @overrides
        def x2
          renderer.years_map[event.time.to.to_i] + 1
        end
      end
    end
  end
end
