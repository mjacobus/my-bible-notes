# frozen_string_literal: true

class TimelinesController < ApplicationController
  include CrudController

  skip_before_action :require_authorization

  key :timeline
  permit :name, :gender, :group_id
  scope { current_user.timelines }
  component_class_template 'Timelines::%{type}PageComponent'
end
