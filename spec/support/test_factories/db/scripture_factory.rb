# frozen_string_literal: true

class TestFactories
  class Db::ScriptureFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        book: bible.to_a.sample.slug,
        title: "Title #{sequency}",
        verses: "1:#{sequency}",
        description: "Description #{sequency}",
        user_id: overrides[:user_id] || users.create.id
      }.merge(overrides)
    end
  end
end
