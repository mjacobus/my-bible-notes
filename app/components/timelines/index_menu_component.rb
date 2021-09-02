# frozen_string_literal: true

module Timelines
  class IndexMenuComponent < Base::ContextMenuComponent
    def initialize(**args)
      super

      if visited_by_owner?
        link(t('app.links.new'), urls.new_timeline_path(current_user))
      end
    end
  end
end
