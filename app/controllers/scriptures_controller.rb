# frozen_string_literal: true

class ScripturesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :scripture

  permit :title, :book, :verses, :description, :parent_id, :tags_string

  form_class Scriptures::Form

  scope do
    profile_owner.scriptures.ordered.with_dependencies.search(params)
  end

  component_class_template 'Scriptures::%{type}PageComponent'

  private

  def form_component(record)
    record.parent_id = parent_id
    super(record)
  end

  def parent_id
    if params[:parent_id]
      current_user.scriptures.find(params[:parent_id])
    end
  end

  def per_page
    params[:per].presence || 200
  end

  def before_show
    unless current_user.is?(profile_owner)
      raise ActiveRecord::RecordNotFound
    end
  end
end
