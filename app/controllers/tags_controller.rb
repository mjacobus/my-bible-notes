# frozen_string_literal: true

class TagsController < ApplicationController
  include CrudController
  skip_before_action :require_authorization
  key :tag
  permit(:name)
  scope { timeline.entries }
  component_class_template 'Tags::%{type}PageComponent'
end
