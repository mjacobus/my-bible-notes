# frozen_string_literal: true

class ControllerAcl
  def initialize(request)
    @request = request
  end

  def authorized?(user)
    unless user
      return false
    end

    if user.master?
      return true
    end

    authorized_controller_action(user)
  end

  def self.controller_actions_for_acl
    Rails.application.routes.routes.map(&:defaults)
      .map { |item| [item[:controller], item[:action]].join('#') }
      .sort
      .uniq
      .reject do |item|
      item.strip == '#' || item.starts_with?(/rails|active_storage|action/)
    end
  end

  private

  def authorized_controller_action(user)
    allowed_items = [
      "#{@request.params[:controller]}##{@request.params[:action]}",
      "#{@request.params[:controller]}#*"
    ]
    (user.permissions['controllers'] & allowed_items).any?
  end
end
