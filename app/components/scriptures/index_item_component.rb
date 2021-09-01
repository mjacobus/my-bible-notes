# frozen_string_literal: true

class Scriptures::IndexItemComponent < ApplicationComponent
  include MenuAwareComponent
  has :scripture
  has :owner
  menu_type :item_options

  private

  def menu_items(menu)
    unless visitor.is?(owner)
      return []
    end

    [
      menu.link(t('app.links.edit'), urls.edit_scripture_path(scripture)),
      menu.link(t('app.links.view'), urls.to(scripture)),
      menu.link(t('app.links.delete'), urls.to(scripture), data: { method: :delete, confirm: delete_warning })
    ]
  end

  def delete_warning
    t('app.messages.confirm_delete')
  end
end
