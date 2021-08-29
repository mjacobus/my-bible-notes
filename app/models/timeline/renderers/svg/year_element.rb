# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class YearElement < BaseElement
        attr_reader :year
        attr_reader :helper

        def initialize(year, render_helper)
          @year = year
          @helper = render_helper
        end

        def title
          @title ||= year.to_s
        end

        def tag
          :line
        end

        def attributes
          {
            x1: x,
            x2: x,
            y1: 15,
            y2: helper.height,
            stroke: color,
            'stroke-width': 1
          }
        end

        def label
          attributes = {
            x: x - 8,
            y: 10,
            'fill': color,
            'font-size': '10',
            'font-family': 'Arial narrow'
          }

          TextElement.new(title, attributes)
        end

        private

        def color
          '#ddd'
        end

        def x
          @x ||= helper.years_map.position_for(year)
        end
      end
    end
  end
end
