# frozen_string_literal: true

class TestFactories
  class Db::TimelineEntryFactory < TestFactories::Factory
    # rubocop:disable Metrics/MethodLength
    def attributes(overrides = {})
      year = (-2000..1000).to_a.sample
      if year.zero?
        year = year.next
      end

      {
        timeline_id: timelines.valid_random_id_or(overrides[:timeline_id]),
        title: "Entry #{seq}",
        from_year: year,
        from_precision: model_class::VALID_PRECISIONS.sample,
        to_year: year + (1..1000).to_a.sample,
        to_precision: model_class::VALID_PRECISIONS.sample
      }.merge(overrides)
    end
  end
end
