# frozen_string_literal: true

module TimelineEntries
  class ShowPageComponent < PageComponent
    has :entry

    private

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        entry: entry,
        context: :show_page
      )
    end

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).show(entry)
    end
  end
end
