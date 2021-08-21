# frozen_string_literal: true

class DevelopmentController < ApplicationController
  skip_before_action :require_authorization

  def login
    session['user_id'] = params[:id] || User.first.id
    redirect_to('/')
  end
end
