# frozen_string_literal: true

module Scriptures
  class ShowPageComponent < PageComponent
    has :record

    def menu
      @menu ||= IndexMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        scripture: record,
        context: :show_page
      )
    end

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).show(record)
    end
  end
end
