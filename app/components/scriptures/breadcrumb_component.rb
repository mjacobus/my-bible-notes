# frozen_string_literal: true

module Scriptures
  class BreadcrumbComponent < Base::BreadcrumbComponent
    def form_for(record)
      if record.id
        index(urls.scriptures_path(profile))
        add(record, urls.to(record))
        return add(t('app.links.edit'))
      end

      add(t('app.links.new'))
    end

    def show(record)
      index(urls.scriptures_path(profile))
      add(record)
    end

    def index(url = nil)
      add(t('app.links.my_scriptures'), url)
      self
    end
  end
end
