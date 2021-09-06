# frozen_string_literal: true

module Tags
  class ShowPageComponent < PageComponent
    has :record

    private

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        record: record,
        context: :show_page
      )
    end

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).show(record)
    end
  end
end
