# frozen_string_literal: true

class Timelines::IndexItemComponent < ApplicationComponent
  include MenuAwareComponent
  has :timeline
  menu_type :item_options

  private

  def menu_items(menu)
    [
      menu.link(t('app.links.edit'), urls.edit_timeline_path(timeline))
    ]
  end
end
