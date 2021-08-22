# frozen_string_literal: true

# rubocop:disable Style/MissingRespondToMissing
class Routes
  def initialize(helpers = Rails.application.routes.url_helpers)
    @helpers = helpers
  end

  def method_missing(*args)
    @helpers.send(*args)
  end

  def timelines_path(user, args = {})
    @helpers.timelines_path(user.username, args)
  end

  def timeline_path(timeline, args = {})
    @helpers.timeline_path(timeline.username, timeline.slug, args)
  end

  def new_timeline_path(user, args = {})
    @helpers.new_timeline_path(user.username, args)
  end

  def edit_timeline_path(timeline, args = {})
    @helpers.edit_timeline_path(timeline.username, timeline.slug, args)
  end

  def to(record, args = {})
    type = record.class.to_s.underscore.tr('db/', '')
    send("#{type}_path", record, args)
  end
end
# rubocop:enable Style/MissingRespondToMissing
