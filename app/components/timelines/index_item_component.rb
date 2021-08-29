# frozen_string_literal: true

class Timelines::IndexItemComponent < ApplicationComponent
  include MenuAwareComponent
  has :timeline
  has :owner
  menu_type :item_options

  def icon_name
    timeline.public? ? 'unlock' : 'lock'
  end

  private

  def menu_items(menu)
    unless visitor.is?(owner)
      return []
    end

    [
      menu.link(t('app.links.timeline_entries'), urls.timeline_entries_path(timeline)),
      menu.link(t('app.links.edit'), urls.edit_timeline_path(timeline)),
      menu.link(t('app.links.view'), urls.to(timeline)),
      menu.link(t('app.links.delete'), urls.to(timeline), data: { method: :delete, confirm: delete_warning })
    ]
  end

  def delete_warning
    t('app.messages.confirm_delete')
  end
end
