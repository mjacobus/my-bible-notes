# frozen_string_literal: true

module Profile
  class EditPageComponent < BaseFormPageComponent
    has :user

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.tap do |b|
        b.add(t('app.links.home'), urls.root_path)
        b.add(t('app.links.profile'))
      end
    end

    def url
      urls.profile_path
    end
  end
end
