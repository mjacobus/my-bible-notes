# frozen_string_literal: true

class TimelineEntries::IndexPageComponent < PageComponent
  has :entries
  paginate :entries

  private

  def setup
    breadcrumb.add(t('app.links.timeline_entries'))
  end

  def menu_items(menu)
    [menu.link(t('app.links.new'), urls.new_timeline_entry_path(entry.timeline))]
  end
end
