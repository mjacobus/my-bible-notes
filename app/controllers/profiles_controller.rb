# frozen_string_literal: true

class ProfilesController < ApplicationController
  skip_before_action :require_authorization
  skip_before_action :check_profile

  def show
    render component
  end

  def update
    current_user.attributes = attributes

    status = :unprocessable_entity

    if current_user.save
      status = :ok
      flash.now[:notice] = t('app.messages.saved')
    end

    render component, status: status
  end

  private

  def component
    Profile::EditPageComponent.new(user: current_user)
  end

  def attributes
    params.require(:profile).permit(:username)
  end
end
