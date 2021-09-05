# frozen_string_literal: true

module Scriptures
  class BreadcrumbComponent < Base::BreadcrumbComponent
    def form_for(record)
      index(urls.scriptures_path(profile))

      up_the_tree_from(record).each do |scripture|
        if record == scripture
          break
        end

        add(scripture, urls.to(scripture))
      end

      if record.id
        add(record, urls.to(record))
        return add(t('app.links.edit'))
      end

      add(t('app.links.new'))
    end

    def show(record)
      index(urls.scriptures_path(profile))
      up_the_tree_from(record).each do |scripture|
        url = scripture == record ? nil : urls.to(scripture)
        add(scripture, url)
      end
      self
    end

    def index(url = nil)
      add(t('app.links.my_scriptures'), url)
      self
    end

    private

    def up_the_tree_from(scripture)
      scriptures = []
      while scripture
        scriptures.unshift(scripture)
        scripture = scripture.parent_scripture
      end
      scriptures
    end
  end
end
