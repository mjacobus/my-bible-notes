# frozen_string_literal: true

class ScripturesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :scripture

  permit :title, :book, :verses, :description

  scope do
    owner.scriptures
  end

  component_class_template 'Scriptures::%{type}PageComponent'

  private

  # def record
  #   @record ||= find_scope.by_slug(params[:id])
  # end

  def before_show
    unless current_user.is?(owner)
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
      other = {}

      if params[:parent_id]
        other[:parent_id] = owner.scriptures.find(parent_id).id
      end

      return super.merge(user_id: current_user.id).merge(other)
    end

    super
  end
end
