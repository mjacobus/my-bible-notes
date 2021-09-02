# frozen_string_literal: true

module Timelines
  class ShowPageComponent < PageComponent
    has :record

    private

    def menu
      @menu ||= ContextMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner,
        timeline: record,
        context: :show_page
      )
    end

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).show(record)
    end

    def menu_items(menu)
      if visitor.is?(current_user)
        [
          menu.link(t('app.links.timeline_entries'), urls.timeline_entries_path(record)),
          menu.link(t('app.links.edit'), urls.edit_timeline_path(record)),
          menu.link(t('app.links.delete'), urls.to(record), data: { method: :delete, confirm: delete_warning })
        ]
      end
    end

    def delete_warning
      t('app.messages.confirm_delete')
    end
  end
end
