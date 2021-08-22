# frozen_string_literal: true

class TestFactories
  class Db::UserFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        name: "User-#{seq}",
        username: "user-#{seq}"
      }.merge(overrides)
    end
  end
end
