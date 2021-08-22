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
      breadcrumb.add(timeline.name, urls.to(timeline))
      breadcrumb.add(t('app.links.edit'))
      return
    end

    breadcrumb.add(t('app.links.new'))
  end
end
