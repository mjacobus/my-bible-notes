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

  def timeline_events
    @timeline_events ||= Timeline::EventFactory.new(self)
  end

  def bible
    @bible ||= Bible::Factory.new.from_config
  end

  def scriptures
    @scriptures ||= Db::ScriptureFactory.new(self)
  end

  def scripture_tags
    @scripture_tags ||= Db::ScriptureTagFactory.new(self)
  end
end
