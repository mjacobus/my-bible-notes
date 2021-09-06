# frozen_string_literal: true

# rubocop:disable Style/MissingRespondToMissing
class Routes
  def initialize(helpers = Rails.application.routes.url_helpers)
    @helpers = helpers
  end

  def method_missing(*args)
    @helpers.send(*args)
  end

  def scriptures_path(user, args = {})
    @helpers.scriptures_path(user.username, args)
  end

  def scripture_path(scripture, args = {})
    @helpers.scripture_path(scripture.username, scripture, args)
  end

  def new_scripture_path(user, args = {})
    @helpers.new_scripture_path(user.username, args)
  end

  def edit_scripture_path(scripture, args = {})
    @helpers.edit_scripture_path(scripture.username, scripture, args)
  end

  def timelines_path(user, args = {})
    @helpers.timelines_path(user.username, args)
  end

  def timeline_path(timeline, args = {})
    @helpers.timeline_path(timeline.username, timeline, args)
  end

  def new_timeline_path(user, args = {})
    @helpers.new_timeline_path(user.username, args)
  end

  def edit_timeline_path(timeline, args = {})
    @helpers.edit_timeline_path(timeline.username, timeline, args)
  end

  def timeline_entries_path(timeline, args = {})
    @helpers.timeline_entries_path(timeline.username, timeline, args)
  end

  def timeline_entry_path(entry, args = {})
    @helpers.timeline_entry_path(entry.timeline.username, entry.timeline, entry, args)
  end

  def new_timeline_entry_path(timeline, args = {})
    @helpers.new_timeline_entry_path(timeline.user.username, timeline, args)
  end

  def edit_timeline_entry_path(entry, args = {})
    @helpers.edit_timeline_entry_path(entry.timeline.username, entry.timeline, entry, args)
  end

  def edit_path(record, args = {})
    type = record.class.to_s.underscore.tr('db/', '')
    send("edit_#{type}_path", record, args)
  end

  def scripture_tag_path(tag, _params = {})
    @helpers.tag_path(tag.user.username, tag, params = {})
  end

  def edit_scripture_tag_path(tag, _params = {})
    @helpers.edit_tag_path(tag.user.username, tag, params = {})
  end

  def scripture_tags_path(profile, params = {})
    @helpers.tags_path(profile.username, params)
  end

  def to(record, args = {})
    type = record.class.to_s.underscore.tr('db/', '')
    send("#{type}_path", record, args)
  end
end
# rubocop:enable Style/MissingRespondToMissing
