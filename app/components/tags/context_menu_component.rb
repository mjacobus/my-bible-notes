# frozen_string_literal: true

module Tags
  class ContextMenuComponent < Base::ContextMenuComponent
    def initialize(**args)
      super

      unless show_page?
        link(t('app.links.view'), urls.to(record))
      end

      if visited_by_owner?
        link(t('app.links.edit'), urls.edit_path(record))
        link(t('app.links.delete'), urls.to(record), data: { method: :delete, confirm: delete_confirmation })
      end
    end
  end
end
