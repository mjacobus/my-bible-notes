module Tags
  class ContextMenuComponent
    def initialize(**args)
      super

      unless show_page?
        link(t('app.links.view'), urls.to(timeline))
      end

      if visited_by_owner?
        link(t('app.links.timeline_entries'), urls.timeline_entries_path(timeline))
        link(t('app.links.edit'), urls.edit_timeline_path(timeline))
        link(t('app.links.delete'), urls.to(timeline), data: { method: :delete, confirm: delete_confirmation })
      end
    end
  end
end
