# frozen_string_literal: true

class TimelinesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :timeline
  permit :name, :slug, :description, :public
  scope { current_user.timelines }
  component_class_template 'Timelines::%{type}PageComponent'

  def record
    @record ||= find_scope.find_by(slug: params[:id])
  end
end
