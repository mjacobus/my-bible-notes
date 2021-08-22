# frozen_string_literal: true

class TimelineEntries::IndexItemComponent < ApplicationComponent
  include MenuAwareComponent
  has :entry
  menu_type :item_options

  private

  def menu_items(menu)
    [
      menu.link(t('app.links.edit'), urls.edit_timeline_entry_path(entry)),
      menu.link(t('app.links.view'), urls.to(entry)),
      menu.link(t('app.links.delete'), urls.to(entry), data: { method: :delete, confirm: delete_warning })
    ]
  end

  def delete_warning
    t('app.messages.confirm_delete')
  end
end
