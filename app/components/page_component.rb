# frozen_string_literal: true

class PageComponent < ApplicationComponent
  include MenuAwareComponent
  menu_type :list_options

  def with_owner_breadcrumb
    breadcrumb.add(owner.username)
  end

  def breadcrumb
    @breadcrumb ||= BreadcrumbComponent.new.tap do |b|
      b.add(t('app.links.home'), urls.root_path)
    end
  end

  def flash
    FlashComponent.new
  end

  def pagination
    PaginationComponent.new(items)
  end

  def self.paginate(method)
    define_method :items do
      send(method)
    end
  end
end
