# frozen_string_literal: true

class TimelinesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :timeline
  permit :name, :slug, :description, :public
  scope do
    if profile_owner.is?(current_user)
      profile_owner.timelines
    else
      profile_owner.timelines.public_timelines
    end
  end
  component_class_template 'Timelines::%{type}PageComponent'

  private

  def record
    @record ||= find_scope.by_slug(params[:id])
  end

  def before_show
    if record.public?
      return
    end

    if current_user.id != profile_owner.id
      raise ActiveRecord::RecordNotFound
    end
  end

  def permitted_attributes
    if action_name == 'create'
      return super.merge(user_id: current_user.id)
    end

    super
  end
end
