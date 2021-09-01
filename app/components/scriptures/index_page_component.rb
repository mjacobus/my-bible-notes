# frozen_string_literal: true

class Scriptures::IndexPageComponent < PageComponent
  include MenuAwareComponent
  has :scriptures
  has :owner
  paginate :scriptures

  private

  def setup
    with_owner_breadcrumb
    breadcrumb.add(t("app.links.my_scriptures"))
  end

  def menu_items(menu)
    unless visitor.is?(owner)
      return []
    end

    [menu.link(t('app.links.new'), urls.new_scripture_path(current_user))]
  end
end
