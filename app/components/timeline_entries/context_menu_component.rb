# frozen_string_literal: true

module TimelineEntries
  class ContextMenuComponent < Base::ContextMenuComponent
    has :entry

    def initialize(**args)
      super

      unless show_page?
        link(t('app.links.view'), urls.to(entry))
      end

      if visited_by_owner?
        link(t('app.links.edit'), urls.edit_timeline_entry_path(entry))
        link(t('app.links.delete'), urls.to(entry), data: { method: :delete, confirm: delete_confirmation })
      end
    end
  end
end
