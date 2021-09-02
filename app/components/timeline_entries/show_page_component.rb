# frozen_string_literal: true

module TimelineEntries
  class ShowPageComponent < PageComponent
    include MenuAwareComponent
    menu_type :list_options
    has :entry
    has :profile_user
    has :current_user

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_user).show(entry)
    end

    def menu_items(menu)
      [
        menu.link(t('app.links.edit'), urls.edit_timeline_entry_path(entry)),
        menu.link(t('app.links.delete'), urls.to(entry), data: { method: :delete, confirm: delete_warning })
      ]
    end

    def delete_warning
      t('app.messages.confirm_delete')
    end
  end
end
