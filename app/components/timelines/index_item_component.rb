# frozen_string_literal: true

module Timelines
  class IndexItemComponent < ApplicationComponent
    has :timeline

    def icon_name
      timeline.public? ? 'unlock' : 'lock'
    end

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        timeline: timeline,
        context: :index_page
      )
    end
  end
end
