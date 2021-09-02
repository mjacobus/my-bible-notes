# frozen_string_literal: true

class TimelineEntriesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :entry

  permit(
    :title,
    :from_year,
    :to_year,
    :from_date_complement,
    :to_date_complement,
    :from_precision,
    :to_precision,
    :confirmed,
    :explanation,
    :color,
    :text,
    :text_properties
  )

  scope { timeline.entries }
  component_class_template 'TimelineEntries::%{type}PageComponent'

  private

  def timeline
    @timeline ||= current_user.timelines.by_slug(params[:timeline_id])
  end

  def component_attributes(attributes)
    attributes.merge(
      profile_owner: profile_owner,
      timeline: timeline
    )
  end
end
