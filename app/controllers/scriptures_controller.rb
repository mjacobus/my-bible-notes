# frozen_string_literal: true

class ScripturesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :scripture

  permit :parent_id, :title, :book, :verses, :description, :parent_id, :tags_string,
         :sequence_number

  form_class Scriptures::Form

  scope do
    profile_owner.scriptures.ordered.with_dependencies.search(params)
  end

  component_class_template 'Scriptures::%{type}PageComponent'

  private

  def after_save_redirect(form)
    if form.record.parent_scripture
      return redirect_to routes.to(form.record.parent_scripture)
    end

    redirect_to routes.to(form.record)
  end

  def after_destroy_redirect(record)
    if record.parent_scripture
      return redirect_to routes.to(record.parent_scripture)
    end

    super(record)
  end

  def form
    super.tap do |f|
      f.parent_id ||= parent_id
    end
  end

  def parent_id
    if params[:parent_id]
      current_user.scriptures.find(params[:parent_id]).id
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
