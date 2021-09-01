# frozen_string_literal: true

module Timelines
  class FormPageComponent < BaseFormPageComponent
    record :timeline
    has :current_user

    private

    def breadcrumb
      @breadcrumb ||= BreadcrumbComponent.new.under_profile(owner).form_for(timeline)
    end

    def setup
      # TODO: Remove later
    end
  end
end
