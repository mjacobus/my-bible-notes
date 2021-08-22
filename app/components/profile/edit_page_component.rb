# frozen_string_literal: true

module Profile
  class EditPageComponent < PageComponent
    has :user

    def url
      urls.profile_path
    end

    private

    def setup
      breadcrumb.add(t('app.links.profile'))
    end
  end
end
