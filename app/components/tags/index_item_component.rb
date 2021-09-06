# frozen_string_literal: true

module Tags
  class IndexItemComponent < ApplicationComponent
    has :record

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        record: record,
        context: :index_page
      )
    end
  end
end
