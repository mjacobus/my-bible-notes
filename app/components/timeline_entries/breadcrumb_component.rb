# frozen_string_literal: true

module TimelineEntries
  class BreadcrumbComponent < Base::BreadcrumbComponent
    def form_for(record)
      # index(urls.timelines_path(profile))
      index(record.timeline)

      if record.id
        add(record.title, urls.to(record))
        return add(t('app.links.edit'))
      end

      add(t('app.links.new'))
    end

    def show(record)
      index(record.timeline, urls.timelines_path(profile))
      add(record.title)
    end

    def index(timeline, _url = nil)
      add(t('app.links.timelines'), urls.timelines_path(profile))
      add(timeline.name, urls.to(timeline))
      add(t('app.links.timeline_entries'), urls.timeline_entries_path(timeline))
    end
  end
end
