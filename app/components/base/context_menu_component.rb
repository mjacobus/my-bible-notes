# frozen_string_literal: true

module Base
  class ContextMenuComponent < ApplicationComponent
    def call
      render menu
    end

    private

    def link(*args)
      menu.item do
        menu.link(*args)
      end
    end

    def menu
      @menu ||= DropdownMenuComponent.new(type: menu_type)
    end

    def menu_type
      index_page? ? :item_options : :list_options
    end

    def index_page?
      context == :index_page
    end

    def show_page?
      context == :show_page
    end

    def delete_confirmation
      t('app.messages.confirm_delete')
    end

    def visited_by_owner?
      current_user.is?(profile_owner)
    end

    def context
      get(:context)
    end
  end
end
