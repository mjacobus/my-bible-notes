# frozen_string_literal: true

class Timelines::IndexPageComponent < PageComponent
  has :timelines
  has :owner
  paginate :timelines

  def new_link
    link_to('foo')
  end

  def setup
    breadcrumb.add(owner.username)
    breadcrumb.add(t('app.links.timelines'))
  end

  private

  def menu_items(menu)
    unless visitor.is?(owner)
      return []
    end

    [menu.link(t('app.links.new'), urls.new_timeline_path(current_user))]
  end
end
