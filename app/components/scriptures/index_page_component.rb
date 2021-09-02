# frozen_string_literal: true

module Scriptures
  class IndexPageComponent < PageComponent
    include MenuAwareComponent
    has :scriptures
    paginate :scriptures

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).index
    end

    def menu_items(menu)
      unless visitor.is?(profile_owner)
        return []
      end

      [menu.link(t('app.links.new'), urls.new_scripture_path(current_user))]
    end
  end
end
