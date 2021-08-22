# frozen_string_literal: true

class Timelines::FormPageComponent < PageComponent
  has :timeline
  has :current_user

  def url
    if timeline.id
      return urls.to(timeline)
    end

    urls.timelines_path(current_user)
  end

  private

  def setup
    breadcrumb.add(t('app.links.timelines'), urls.timelines_path(current_user))

    if timeline.id?
      return breadcrumb.add(t('app.links.timelines'), urls.to(timeline))
    end

    breadcrumb.add(t('app.links.new'))
  end
end
