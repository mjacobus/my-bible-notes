# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength:
class Timelines::TimelineComponent < ApplicationComponent
  has :timeline
  has :entries

  COLORS = %w[
    red
    orange
    blue
    green
    black
  ].freeze

  def height
    entry_y(entries.last) + stroke_width
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

  def render?
    entries.any?
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

  def entry_x1(entry)
    years_map[entry.from_year]
  end

  def entry_x2(entry)
    increment = entry.single_year? ? 1 : 0
    years_map[entry.to_year] + increment
  end

  def entry_y(entry)
    height = stroke_width + space_between_lines
    index = index_of(entry)
    index * height + 1 + (stroke_width / 2)
  end

  def entry_color(_entry)
    @last_color ||= 0
    COLORS[@last_color % COLORS.length].tap do
      @last_color += 1
    end
  end

  def index_of(entry)
    entries.find_index(entry)
  end

  def start_at
    @start_at ||= entries.first.from_year
  end

  def starting_at(value)
    @start_at = value.to_i
    @years_map = nil
    self
  end

  def end_at
    @end_at ||= entries.last.to_year
  end

  def ending_at(value)
    @end_at = value.to_i
    @years_map = nil
    self
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
end
# rubocop:enable Metrics/ClassLength:
