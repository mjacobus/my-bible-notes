# frozen_string_literal: true

module Scriptures
  class ShowPageComponent < PageComponent
    include MenuAwareComponent
    menu_type :list_options
    has :scripture
    has :current_user, optional: true

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).show(scripture)
    end

    def menu_items(menu)
      if visitor.is?(current_user)
        [
          menu.link(t('app.links.edit'), urls.edit_scripture_path(scripture)),
          menu.link(t('app.links.delete'), urls.to(scripture), data: { method: :delete, confirm: delete_warning })
        ]
      end
    end

    def delete_warning
      t('app.messages.confirm_delete')
    end
  end
end
