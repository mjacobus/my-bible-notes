# frozen_string_literal: true

class TestFactories
  def timelines
    @timelines ||= Db::TimelineFactory.new(self)
  end

  def timeline_entries
    @timeline_entries ||= Db::TimelineEntryFactory.new(self)
  end

  def users
    @users ||= Db::UserFactory.new(self)
  end
end
