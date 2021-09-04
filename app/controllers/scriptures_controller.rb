# frozen_string_literal: true

class ScripturesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :scripture

  permit :title, :book, :verses, :description, :parent_id, :tags_string

  form_class Scriptures::Form

  scope do
    profile_owner.scriptures.ordered.with_dependencies
  end

  component_class_template 'Scriptures::%{type}PageComponent'

  private

  def record
    profile_owner.scriptures.find(params[:id])
  end

  def before_show
    unless current_user.is?(profile_owner)
      raise ActiveRecord::RecordNotFound
    end
  end
end
