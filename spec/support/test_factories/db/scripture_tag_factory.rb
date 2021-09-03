# frozen_string_literal: true

class TestFactories
  class Db::ScriptureTagFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        name: "Tag #{sequency}",
        user_id: overrides[:user_id] || users.create.id
      }.merge(overrides)
    end
  end
end
