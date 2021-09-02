# frozen_string_literal: true

module TimelineEntries
  class IndexPageComponent < PageComponent
    has :timeline
    has :entries
    paginate :entries

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

    def menu_items(menu)
      [menu.link(t('app.links.new'), urls.new_timeline_entry_path(timeline))]
    end
  end
end
