# frozen_string_literal: true

module Timelines
  class FormPageComponent < PageComponent
    include Base::FormComponent

    record :form

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(profile_owner).form_for(form.record)
    end
  end
end
