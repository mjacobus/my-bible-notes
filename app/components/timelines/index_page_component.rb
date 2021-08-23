# frozen_string_literal: true

class Timelines::IndexPageComponent < PageComponent
  has :timelines
  paginate :timelines

  private

  def setup
    breadcrumb.add(t('app.links.timelines'))
  end

  def menu_items(menu)
    [menu.link(t('app.links.new'), urls.new_timeline_path(current_user))]
  end
end
