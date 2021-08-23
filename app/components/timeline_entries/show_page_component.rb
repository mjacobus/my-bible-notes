# frozen_string_literal: true

class TimelineEntries::ShowPageComponent < PageComponent
  include MenuAwareComponent
  menu_type :list_options
  has :entry
  has :current_user

  private

  def setup
    breadcrumb.add(t('app.links.timelines'), urls.timelines_path(current_user))
    breadcrumb.add(entry.timeline.name, urls.timeline_path(entry.timeline))
    breadcrumb.add(t('app.links.timeline_entries'), urls.timeline_entries_path(entry.timeline))
  end

  def menu_items(menu)
    [
      menu.link(t('app.links.edit'), urls.edit_timeline_entry_path(entry)),
      menu.link(t('app.links.delete'), urls.to(entry), data: { method: :delete, confirm: delete_warning })
    ]
  end

  def delete_warning
    t('app.messages.confirm_delete')
  end
end
