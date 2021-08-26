# frozen_string_literal: true

class TestFactories
  class Db::TimelineFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        user_id: users.valid_random_id_or(overrides[:user_id]),
        name: "Timeline-#{seq}",
        slug: "timeline-#{seq}",
        description: 'Some Description',
      }.merge(overrides)
    end
  end
end
