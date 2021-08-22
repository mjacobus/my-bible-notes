# frozen_string_literal: true

class Timelines::IndexPageComponent < PageComponent
  has :timelines
  paginate :timelines

  def new_link
    link_to('foo')
  end

  def setup
    breadcrumb.add(t('app.links.timelines'))
  end

  private

  def menu_items(menu)
    [menu.link(t('app.links.new'), urls.new_timeline_path(current_user))]
  end
end
