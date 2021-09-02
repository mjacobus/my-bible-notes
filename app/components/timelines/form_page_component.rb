# frozen_string_literal: true

module Timelines
  class FormPageComponent < PageComponent
    include Base::FormComponent

    record :timeline
    has :current_user

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(owner).form_for(timeline)
    end
  end
end
