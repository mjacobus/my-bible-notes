# frozen_string_literal: true

module Scriptures
  class ShowPageComponent < PageComponent
    has :scripture

    def menu
      @menu ||= IndexMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        scripture: scripture,
        context: :show_page
      )
    end

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).show(scripture)
    end
  end
end
