# frozen_string_literal: true

module Timelines
  class BreadcrumbComponent < Base::BreadcrumbComponent
    def form_for(record)
      index(urls.timelines_path(profile))

      if record.id
        add(record.name, urls.to(record))
        return add(t('app.links.edit'))
      end

      add(t('app.links.new'))
    end

    def show(record)
      index(urls.timelines_path(profile))
      add(record.name)
    end

    def index(url = nil)
      add(t('app.links.timelines'), url)
      self
    end
  end
end
