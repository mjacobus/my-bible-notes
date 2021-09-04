# frozen_string_literal: true

module Scriptures
  class ContextMenuComponent < Base::ContextMenuComponent
    has :scripture

    def initialize(**args)
      super

      unless show_page?
        link(t('app.links.view'), urls.to(scripture))
      end

      if visited_by_owner?
        link(t('app.links.add_related_scripture'), urls.new_scripture_path(scripture.user, parent_id: scripture.id))
        link(t('app.links.edit'), urls.edit_scripture_path(scripture))
        link(t('app.links.delete'), urls.to(scripture), data: { method: :delete, confirm: delete_confirmation })
      end
    end

    private

    def title
      scripture.to_s
    end
  end
end
