# frozen_string_literal: true

class TimelineEntriesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :entry
  permit :title, :year, :date_complement, :explanation, :precision, :confirmed
  scope { current_user.timelines.by_slug(params[:timeline_id]) }
  component_class_template 'TimelineEntries::%{type}PageComponent'

  # def record
  #   @record ||= find_scope.by_slug(params[:id])
  # end
end
