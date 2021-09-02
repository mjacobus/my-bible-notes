# frozen_string_literal: true

module Scriptures
  class IndexItemComponent < ApplicationComponent
    has :scripture

    def level
      get(:level).to_i + 1
    end

    private

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        scripture: scripture,
        context: :index_page
      )
    end
  end
end
