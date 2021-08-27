# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class Helper
        def initialize(timeline)
          @timeline = timeline
        end

        def events
          @events ||= timeline.events.sort_by { |event| event.time.from.to_i }
        end

        def renderable_events
          @renderable_events ||= events.map do |event|
            decorate_event(event)
          end
        end

        def with_lane_spacing(spacing)
          @lane_spacing = spacing
          self
        end

        def lane_spacing
          @lane_spacing ||= 4
        end

        def with_lane_height(height)
          @lane_height = height
          self
        end

        def lane_height
          @lane_height ||= 10
        end

        def height
          @height ||= begin
            padding_top + timeline.lanes.length  * (lane_height + lane_spacing) + padding_bottom
          end
        end

        def width
          @width ||= years_map.length
        end

        def with_padding_top(padding)
          @padding_top = padding
          self
        end

        def padding_top
          @padding_top ||= 10
        end

        def with_padding_bottom(padding)
          @padding_bottom = padding
          self
        end

        def padding_bottom
          @padding_bottom ||= 10
        end

        def years_interval
          @years_interval ||= 50
        end

        def with_years_interval(number)
          @years_interval = number
          self
        end

        def years_to_display
          (start_at..end_at).to_a.select do |number|
            if number.zero?
              next
            end
            if number == 1
              next true
            end

            (number % years_interval).zero?
          end
        end

        def years_map
          @years_map ||= Svg::YearsMap.new(from: start_at, to: end_at)
        end

        def space_between_lines
          @space_between_lines ||= 2
        end

        def year_x(year)
          years_map.position_for(year)
        end

        def start_at
          @start_at ||= events.map { |event| event.time.from.to_i }.min
        end

        def starting_at(value)
          @start_at = value.to_i
          @years_map = nil
          self
        end

        def end_at
          @end_at ||= events.map { |event| event.time.to.to_i }.max
        end

        def ending_at(value)
          @end_at = value.to_i
          @years_map = nil
          self
        end

        private

        attr_reader :timeline

        def decorate_event(event)
          if event.single_year?
            return Svg::OneTimeEventElement.new(event, self)
          end

          Svg::TimeRangeEventElement.new(event, self)
        end

        def next_color
          @last_color ||= 0
          COLORS[@last_color % COLORS.length].tap do
            @last_color += 1
          end
        end
      end
    end
  end
end
