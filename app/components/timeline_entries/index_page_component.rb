# frozen_string_literal: true

class TimelineEntries::IndexPageComponent < PageComponent
  has :timeline
  has :entries
  has :current_user
  paginate :entries

  private

  def setup
    breadcrumb.add(t('app.links.timelines'), urls.timelines_path(current_user))
    breadcrumb.add(timeline.name, urls.timeline_path(timeline))
    breadcrumb.add(t('app.links.timeline_entries'))
  end

  def menu_items(menu)
    [menu.link(t('app.links.new'), urls.new_timeline_entry_path(timeline))]
  end
end
