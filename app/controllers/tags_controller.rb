# frozen_string_literal: true

class TagsController < ApplicationController
  include CrudController
  skip_before_action :require_authorization
  key :tag
  permit(:name, :color)
  scope { profile_owner.tags }
  component_class_template 'Tags::%{type}PageComponent'
end
