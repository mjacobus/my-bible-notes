# frozen_string_literal: true

class TimelinesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :timeline
  permit :name, :slug, :description, :public
  scope do
    if owner.is?(current_user)
      owner.timelines
    else
      owner.timelines.public_timelines
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

    if current_user.id != owner.id
      raise ActiveRecord::RecordNotFound
    end
  end

  def component_attributes(attributes)
    attributes.merge(owner: owner)
  end

  def owner
    @owner ||= Db::User.find_by(username: params[:username])
  end

  def permitted_attributes
    if action_name == 'create'
      return super.merge(user_id: current_user.id)
    end

    super
  end
end
