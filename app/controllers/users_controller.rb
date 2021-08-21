# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_master_user

  def index
    @users = User.order(:email)
  end

  def enable
    change_user_attribute(:enabled, true)
    redirect_to(users_path)
  end

  def disable
    change_user_attribute(:enabled, false)
    redirect_to(users_path)
  end

  def grant_admin
    change_user_attribute(:master, true)
    redirect_to(users_path)
  end

  def revoke_admin
    change_user_attribute(:master, false)
    redirect_to(users_path)
  end

  private

  def require_master_user
    unless current_user.master?
      redirect_to('/')
    end
  end

  def change_user_attribute(attribute_name, new_value)
    user = User.find(params[:id])
    user.attributes = { attribute_name => new_value }
    user.save!
  end
end
