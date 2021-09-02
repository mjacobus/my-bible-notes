# frozen_string_literal: true

module Timelines
  class IndexPageComponent < PageComponent
    has :timelines
    paginate :timelines

    private

    def new_link
      link_to('foo')
    end

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).index
    end

    def menu_items(menu)
      unless visitor.is?(profile_owner)
        return []
      end

      [menu.link(t('app.links.new'), urls.new_timeline_path(current_user))]
    end
  end
end
