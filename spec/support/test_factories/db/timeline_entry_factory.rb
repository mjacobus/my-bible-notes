# frozen_string_literal: true

class TestFactories
  class Db::TimelineEntryFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        timeline_id: timelines.valid_random_id_or(overrides[:timeline_id]),
        title: "Entry #{seq}",
        year: (-4050..(Time.zone.today.year)).to_a.sample,
        precision: model_class::VALID_PRECISIONS.sample,
        confirmed: [true, false].sample
      }.merge(overrides)
    end
  end
end
