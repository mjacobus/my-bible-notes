# frozen_string_literal: true

module Tags
  class IndexMenuComponent < Base::ContextMenuComponent
    def initialize(**args)
      super

      if visited_by_owner?
        link(t('app.links.new'), urls.new_tag_path(current_user))
      end
    end
  end
end

