# frozen_string_literal: true

module TimelineEntries
  class IndexPageComponent < PageComponent
    has :timeline
    has :entries
    has :current_user
    has :profile_owner
    paginate :entries

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).index(timeline)
    end

    def menu_items(menu)
      [menu.link(t('app.links.new'), urls.new_timeline_entry_path(timeline))]
    end
  end
end
