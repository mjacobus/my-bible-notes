# frozen_string_literal: true

module Scriptures
  class IndexMenuComponent < Base::ContextMenuComponent
    def initialize(**args)
      super

      if visited_by_owner?
        link(t('app.links.new'), urls.new_scripture_path(current_user))
      end
    end
  end
end
