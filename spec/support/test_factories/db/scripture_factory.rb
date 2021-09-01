# frozen_string_literal: true

class TestFactories
  class Db::ScriptureFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        book: bible.to_a.sample.slug,
        title: "Title #{sequency}",
        verses: "1:#{sequency}",
        description: "Description #{sequency}",
        user_id: users.valid_random_id_or(overrides[:user_id])
      }
    end
  end
end
