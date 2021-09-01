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
    # def setup
    #   with_owner_breadcrumb
    #   breadcrumb.add(t('app.links.timelines'), urls.timelines_path(current_user))
    #
    #   if timeline.id?
    #     breadcrumb.add(timeline.name, urls.to(timeline))
    #     breadcrumb.add(t('app.links.edit'))
    #     return
    #   end
    #
    #   breadcrumb.add(t('app.links.new'))
    # end
  end
end
