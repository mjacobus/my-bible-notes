# frozen_string_literal: true

module Scriptures
  class IndexPageComponent < PageComponent
    has :collection

    private

    def menu
      @menu ||= IndexMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner
      )
    end

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).index
    end
  end
end
