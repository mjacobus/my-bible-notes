# frozen_string_literal: true

module TimelineEntries
  class FormPageComponent < PageComponent
    include Base::FormComponent

    record :entry
    has :current_user
    has :profile_user

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

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_user).form_for(entry)
    end
  end
end
