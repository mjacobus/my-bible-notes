# frozen_string_literal: true

module Sidebar
  class MenuEntry
    attr_reader :url, :text, :children, :icon

    def initialize(text, url, icon: nil)
      @text = text
      @url = url
      @children = []
      @icon = icon
    end

    def append_child(child)
      @children << child
    end

    def visible?(user)
      if children.any?
        return children.any? { |child| child.visible?(user) }
      end

      UrlAcl.new(url).authorized?(user)
    end

    def active?(url)
      if children.any?
        return children.any? { |child| child.active?(url) }
      end

      url_controller = Rails.application.routes.recognize_path(url)[:controller]
      controller = Rails.application.routes.recognize_path(@url)[:controller]

      if url_controller == controller
        Rails.logger.debug([url_controller, controller].inspect)
        return true
      end

      controller != 'home' && url.include?(@url)
    rescue ActionController::RoutingError
      false
    end
  end
end
