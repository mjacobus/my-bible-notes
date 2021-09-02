# frozen_string_literal: true

module TimelineEntries
  class IndexItemComponent < ApplicationComponent
    has :entry

    private

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        entry: entry,
        context: :index_page
      )
    end
  end
end
