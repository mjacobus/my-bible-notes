# frozen_string_literal: true

module TimelineEntries
  class IndexPageComponent < PageComponent
    has :timeline
    has :collection

    private

    def menu
      @menu ||= IndexMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        timeline: timeline
      )
    end

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).index(timeline)
    end
  end
end
