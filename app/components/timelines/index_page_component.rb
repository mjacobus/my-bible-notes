# frozen_string_literal: true

class Timelines::IndexPageComponent < PageComponent
  has :timelines
  paginate :timelines

  def new_link
    link_to('foo')
  end

  def menu
    DropdownMenuComponent.new(type: :list_options).tap do |menu|
      menu.item { menu.link(t('app.links.new'), urls.new_timeline_path(current_user) ) }
    end
  end
end
