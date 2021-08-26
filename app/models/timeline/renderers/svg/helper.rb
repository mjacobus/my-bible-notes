# frozen_string_literal: true

module Timeline
  module Renderers
    module Svg
      class Helper
        def initialize(timeline)
          @timeline = timeline
        end

        def events
          @events ||= @timeline.events.sort_by { |event| event.time.from.to_i }
        end

        def renderable_events
          @renderable_events ||= events.map do |event|
            decorate_event(event)
          end
        end

        def decorate_event(event)
          if event.single_year?
            return RendererableEvent.new(event, self)
          end

          RendererableTimeRangeEvent.new(event, self)
        end

        def height
          event_y(events.last) + stroke_width
        end

        def width
          # give 1 pixel more to draw the last year
          years_map.values.last + 1
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
          @years_map ||= resolve_years
        end

        def stroke_width
          @stroke_width ||= 10
        end

        def with_stroke_width(value)
          @stroke_width = value
          self
        end

        def space_between_lines
          @space_between_lines ||= 2
        end

        def with_space_between_lines(value)
          @space_between_lines = value
          self
        end

        def year_x(year)
          years_map[year]
        end

        def event_x1(event)
          # decorate_event(event).attributes[:x1]
          years_map[event.time.from.to_i]
        end

        def event_x2(event)
          increment = event.single_year? ? 1 : 0
          years_map[event.time.to.to_i] + increment
        end

        def event_y(event)
          height = stroke_width + space_between_lines
          index = index_of(event)
          index * height + 1 + (stroke_width / 2)
        end

        def event_color(event)
          event.color.presence || next_color
        end

        def index_of(event)
          events.find_index(event)
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

        def popover_title(event)
          years = [event.time.from.to_s]

          unless event.single_year?
            years.push(event.time.to.to_s)
          end

          [[years].compact.join(' - '), event.title].compact.join(": \n")
        end

        def popover_content(event)
          event.explanation
        end

        private

        # { year -> position }
        def resolve_years
          map = {}
          i = 0
          (start_at..end_at).each do |year|
            next if year.zero?

            i += 1
            map[year] = i
          end
          map
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
