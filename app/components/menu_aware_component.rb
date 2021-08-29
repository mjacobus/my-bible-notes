# frozen_string_literal: true

module MenuAwareComponent
  extend ActiveSupport::Concern

  def menu
    @menu ||= DropdownMenuComponent.new(type: menu_type).tap do |menu|
      Array.wrap(menu_items(menu)).each do |item|
        menu.item { item }
      end
    end
  end

  module ClassMethods
    def menu_type(type)
      define_method :menu_type do
        type
      end
    end
  end
end
