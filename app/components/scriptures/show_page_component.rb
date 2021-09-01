# frozen_string_literal: true

class Scriptures::ShowPageComponent < PageComponent
  include MenuAwareComponent
  menu_type :list_options
  has :scripture
  has :current_user, optional: true
  has :owner

  private

  def setup
    breadcrumb.add(t('app.links.my_scriptures'), urls.scriptures_path(owner))
    breadcrumb.add(scripture.to_s)
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
