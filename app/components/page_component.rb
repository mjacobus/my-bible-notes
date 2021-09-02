# frozen_string_literal: true

class PageComponent < ApplicationComponent
  def breadcrumb
    @breadcrumb ||= BreadcrumbComponent.new.tap do |b|
      b.add(t('app.links.home'), urls.root_path)
    end
  end

  def flash
    FlashComponent.new
  end

  def pagination
    PaginationComponent.new(collection)
  end
end
