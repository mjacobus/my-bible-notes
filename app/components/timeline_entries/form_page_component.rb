# frozen_string_literal: true

class TimelineEntries::FormPageComponent < PageComponent
  has :entry
  has :current_user

  def url
    if entry.id
      return urls.to(entry)
    end

    urls.timeline_entries_path(entry.timeline)
  end

  def precisions
    Db::TimelineEntry::VALID_PRECISIONS.map do |precision|
      [t("app.attributes.precisions.#{precision}"), precision]
    end
  end

  def random_color
    "##{SecureRandom.hex(3)}"
  end

  private

  def setup
    breadcrumb.add(t('app.links.timelines'), urls.timelines_path(current_user))
    breadcrumb.add(entry.timeline.name, urls.timeline_path(entry.timeline))
    breadcrumb.add(t('app.links.timeline_entries'), urls.timeline_entries_path(entry.timeline))

    if entry.id.present?
      breadcrumb.add(entry.title, urls.to(entry))
      breadcrumb.add(t('app.links.edit'))
      return
    end
    breadcrumb.add(t('app.links.new'))
  end
end
