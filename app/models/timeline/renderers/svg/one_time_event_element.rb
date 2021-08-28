# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class OneTimeEventElement < BaseElement
        def width
          event.time.length + 1
        end
      end
    end
  end
end
