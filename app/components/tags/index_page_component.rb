# frozen_string_literal: true

module Tags
  class IndexPageComponent < PageComponent
    has :collection

    def menu
      @menu ||= IndexMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner
      )
    end

    def item_component(record)
      IndexItemComponent.new(record: record, profile_owner: profile_owner)
    end

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).index
    end
  end
end
