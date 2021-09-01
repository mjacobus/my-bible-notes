# frozen_string_literal: true

module Timelines
  class ShowPageComponent < PageComponent
    include MenuAwareComponent
    menu_type :list_options
    has :timeline
    has :current_user, optional: true
    has :owner

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(owner).show(timeline)
    end

    def menu_items(menu)
      if visitor.is?(current_user)
        [
          menu.link(t('app.links.timeline_entries'), urls.timeline_entries_path(timeline)),
          menu.link(t('app.links.edit'), urls.edit_timeline_path(timeline)),
          menu.link(t('app.links.delete'), urls.to(timeline), data: { method: :delete, confirm: delete_warning })
        ]
      end
    end

    def delete_warning
      t('app.messages.confirm_delete')
    end
  end
end
