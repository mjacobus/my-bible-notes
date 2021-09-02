# frozen_string_literal: true

module TimelineEntries
  class IndexMenuComponent < Base::ContextMenuComponent
    has :timeline

    def initialize(**args)
      super

      if visited_by_owner?
        link(t('app.links.new'), urls.new_timeline_entry_path(timeline))
      end
    end
  end
end
