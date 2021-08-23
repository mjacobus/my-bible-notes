# frozen_string_literal: true

class Timelines::ShowPageComponent < PageComponent
  include MenuAwareComponent
  menu_type :list_options
  has :timeline
  has :current_user

  private

  def setup
    breadcrumb.add(t('app.links.timelines'), urls.timelines_path(current_user))
    breadcrumb.add(timeline.name)
  end

  def menu_items(menu)
    [
      menu.link(t('app.links.timeline_entries'), urls.timeline_entries_path(timeline)),
      menu.link(t('app.links.edit'), urls.edit_timeline_path(timeline)),
      menu.link(t('app.links.delete'), urls.to(timeline), data: { method: :delete, confirm: delete_warning })
    ]
  end

  def delete_warning
    t('app.messages.confirm_delete')
  end
end
