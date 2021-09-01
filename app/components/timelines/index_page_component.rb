# frozen_string_literal: true

class Timelines::IndexPageComponent < PageComponent
  has :timelines
  has :owner
  paginate :timelines

  private

  def new_link
    link_to('foo')
  end

  def setup
    with_owner_breadcrumb
    breadcrumb.add(t('app.links.timelines'))
  end

  def menu_items(menu)
    unless visitor.is?(owner)
      return []
    end

    [menu.link(t('app.links.new'), urls.new_timeline_path(current_user))]
  end
end
