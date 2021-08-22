# frozen_string_literal: true

class TestFactories
  def timelines
    @timelines ||= Db::TimelineFactory.new(self)
  end

  def users
    @users ||= Db::UserFactory.new(self)
  end
end
