# frozen_string_literal: true

class TestFactories
  def users
    @users ||= UserFactory.new(self)
  end

  class UserFactory < Factory
    def attributes(overrides = {})
      { name: "User-#{seq}" }.merge(overrides)
    end
  end
end
