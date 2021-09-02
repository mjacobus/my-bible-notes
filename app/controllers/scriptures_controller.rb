# frozen_string_literal: true

class ScripturesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :scripture

  permit :title, :book, :verses, :description

  scope do
    profile_owner.scriptures.ordered
  end

  component_class_template 'Scriptures::%{type}PageComponent'

  private

  def before_show
    unless current_user.is?(profile_owner)
      raise ActiveRecord::RecordNotFound
    end
  end

  def component_attributes(attributes)
    attributes.merge(profile_owner: profile_owner)
  end

  def permitted_attributes
    if action_name == 'create'
      other = {}

      if params[:parent_id]
        other[:parent_id] = profile_owner.scriptures.find(parent_id).id
      end

      return super.merge(user_id: current_user.id).merge(other)
    end

    super
  end
end
