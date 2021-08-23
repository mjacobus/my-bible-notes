# frozen_string_literal: true

class TimelineEntries::TimeRangeComponent < AttributeWrapperComponent
  def initialize(entry:)
    @value = [entry.formatted_from_year, entry.formatted_to_year].join(' - ')
    with_label(:time_range)
    without_label
  end

  def icon_name
    'calendar-date'
  end
end
