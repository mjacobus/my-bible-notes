# frozen_string_literal: true

module Profile
  class EditPageComponent < BaseFormPageComponent
    has :user

    def initialize(*args)
      super

      breadcrumb.add(t('app.links.profile'))
    end

    def url
      urls.profile_path
    end
  end
end
