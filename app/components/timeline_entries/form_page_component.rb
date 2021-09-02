# frozen_string_literal: true

module TimelineEntries
  class FormPageComponent < PageComponent
    include Base::FormComponent

    has :form

    def target_url
      if form.id
        return urls.to(form.record)
      end

      urls.timeline_entries_path(form.record.timeline)
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
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).form_for(form.record)
    end
  end
end
